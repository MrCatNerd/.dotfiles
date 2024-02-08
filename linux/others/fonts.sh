#!/bin/env bash

echo "Setting up nerd fonts"

declare -a fonts=(
    # FiraCode
    # FiraMono
    Hack
)

version="3.1.1" # TODO: find a way to get the latest version automatically
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    zip_file="/tmp/${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    curl -sSfL -o "$zip_file" "$download_url"
    unzip "$zip_file" -d "$fonts_dir" -x "*.txt/*" -x "*.md/*"
    rm "$zip_file"
done

find "$fonts_dir" -name "*Windows Compatible*" -delete

fc-cache -fv

echo Finished setting up nerd fonts

