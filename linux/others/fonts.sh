#!/usr/bin/env bash

echo "Setting up Nerd Fonts"

sudo apt-get install -y curl unzip fontconfig

# space seperated list of fonts lol:
FONTS="FiraCode FiraMono Hack"

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

for font_name in $FONTS; do
    echo "Downloading $font_name Nerd Font..."

    URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font_name}.zip"
    ZIP_FILE="/tmp/${font_name}.zip"

    echo "$URL"

    curl -fLo "$ZIP_FILE" "$URL" || {
        echo "Failed to download $font_name"
        continue
    }

    echo "Unzipping $font_name..."
    unzip -o "$ZIP_FILE" -d "$FONT_DIR/$font_name/"

    rm -f "$ZIP_FILE"
done

echo "Refreshing font cache..."
fc-cache -fv

echo "Finished setting up Nerd Fonts"
