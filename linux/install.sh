#!/usr/bin/env bash

sudo apt install -y stow

pushd "$DOTFILES"

for folder in $(echo "$STOW_FOLDERS" | sed "s/,/ /g")
do
    echo "stow $folder"
    stow -D "$folder"
    stow "$folder"
done

if [ "$(dirs -c)" ]; then
    popd
fi

