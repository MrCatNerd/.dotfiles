#!/bin/env bash

if ! which git_release_puller > /dev/null 2>&1; then
    echo "git_release_puller not found, skipping nerd fonts!"
    echo "make sure you stowed the .local/bin folder!"
    exit 1
fi

source git_release_puller

echo "Setting up nerd fonts"

# space to seperate
FONTS="FiraCode FiraMono Hack"

# time to (ab)use sed to overcomplicate my script
FONTS=$(echo "$FONTS " | sed "s/ /.zip /g")

fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

if [[ ! -d "/tmp/nerd-fonts" ]]; then
    mkdir -p "/tmp/nerd-fonts"
else
    rm -f "/tmp/nerd-fonts/*"
fi

PULL_RELEASE_GH "/tmp/fonts/" "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" "browser_download_url" "$FONTS"
for font in $("$FONTS" | sed "s/ /\n/g"); do
    zip_file="/tmp/nerd-fonts/${font}.zip"
    unzip "$zip_file" -d "$fonts_dir" -x "*.txt/*" -x "*.md/*"
done

find "$fonts_dir" -name "*Windows Compatible*" -delete

fc-cache -fv

echo Finished setting up nerd fonts

