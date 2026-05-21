#!/usr/bin/env bash

# i made this with ai cuz i just want to play some fucking osu
# hopefully they add a flatpak (or .deb/.rpm) release in the future cuz appimage sucks

set -euo pipefail

# where the AppImage will be installed
APPIMAGE_PATH="/opt/osu-lazer.AppImage"

# where the desktop icon will be stored
ICON_PATH="/opt/osu-lazer.png"

# desktop entry used by app launchers
DESKTOP_FILE="$HOME/.local/share/applications/osu-lazer.desktop"

# load distro information from os-release
source /etc/os-release

# install required dependencies
case "$ID" in
    ubuntu|debian|linuxmint|pop)
        sudo apt-get update
        sudo apt-get install -y curl jq libfuse2 desktop-file-utils
        ;;
    fedora)
        sudo dnf install -y curl jq fuse-libs desktop-file-utils
        ;;
    *)
        echo "Unsupported distro: $ID"
        exit 1
        ;;
esac

# set the GitHub API URL for osu!lazer releases
API_URL="https://api.github.com/repos/ppy/osu/releases/latest"

# use curl to fetch the latest release info from GitHub API
LATEST_RELEASE_URL=$(
    curl -s "$API_URL" |
    jq -r '.assets[] | select(.name == "osu.AppImage") | .browser_download_url'
)

# check if the URL is valid
if [ -z "$LATEST_RELEASE_URL" ] || [ "$LATEST_RELEASE_URL" = "null" ]; then
    echo "Error: Could not find the latest osu!lazer AppImage."
    exit 1
fi

# download the latest osu!lazer AppImage to /tmp
curl -L -o "/tmp/osu-lazer.AppImage" "$LATEST_RELEASE_URL"

# move it to /opt for easy management
sudo mv /tmp/osu-lazer.AppImage "$APPIMAGE_PATH"

# make the AppImage executable
chmod +x "$APPIMAGE_PATH"

# download the icon image
# raw.githubusercontent URL is cleaner than GitHub blob URLs
ICON_URL="https://raw.githubusercontent.com/ppy/osu/master/assets/lazer-nuget.png"

sudo curl -L -o "$ICON_PATH" "$ICON_URL"

# make sure the applications directory exists
mkdir -p "$HOME/.local/share/applications"

# create a .desktop file for easy launching (too lazy to set version)
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Name=osu! Lazer
Comment=Play osu! Lazer (open-source rhythm game)
Exec=$APPIMAGE_PATH
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Game;
EOF

# update desktop database if the command exists
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$HOME/.local/share/applications/"
fi

echo "osu!lazer is installed and ready to use!"
