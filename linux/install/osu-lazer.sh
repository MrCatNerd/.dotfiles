#!/bin/env bash

# i made this with ai cuz i just want to play some fucking osu
# hopefully they add a .deb release in the future cuz appimage sucks for this

# install required dependency
sudo apt-get install -y libfuse2

# set the GitHub API URL for osu!lazer releases
API_URL="https://api.github.com/repos/ppy/osu/releases/latest"

# use curl to fetch the latest release info from GitHub API
LATEST_RELEASE_URL=$(curl -s $API_URL | jq -r '.assets[] | select(.name == "osu.AppImage") | .browser_download_url')

# check if the URL is valid
if [ -z "$LATEST_RELEASE_URL" ]; then
  echo "Error: Could not find the latest osu!lazer AppImage."
  exit 1
fi

# download the latest osu!lazer AppImage
curl -L -o "/tmp/osu-lazer.AppImage" "$LATEST_RELEASE_URL"

# make the AppImage executable
chmod +x /tmp/osu-lazer.AppImage

# move it to /opt or any directory for easy management
sudo mv /tmp/osu-lazer.AppImage /opt/osu-lazer.AppImage

# download the icon image
ICON_URL="https://github.com/ppy/osu/blob/master/assets/lazer-nuget.png?raw=true"
sudo curl -L -o "/opt/osu-lazer.png" "$ICON_URL"

# create a .desktop file for easy launching
echo "[Desktop Entry]
Version=1.0
Name=osu! Lazer
Comment=Play osu! Lazer (open-source rhythm game)
Exec=/opt/osu-lazer.AppImage
Icon=/opt/osu-lazer.png
Terminal=false
Type=Application
Categories=Game;
" > ~/.local/share/applications/osu-lazer.desktop

# update desktop database
update-desktop-database ~/.local/share/applications/

echo "osu!lazer is installed and ready to use!"
