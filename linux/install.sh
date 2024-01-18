#!/usr/bin/env bash

sudo apt install -y stow

pushd "$DOTFILES"

for folder in $(echo "$STOW_FOLDERS" | sed "s/,/ /g")
do
    echo "stow $folder"
    stow -D "$folder"
    stow "$folder"

    script_path="./install/$folder.sh"

    if [ -f "$script_path" ]; then
        echo "Executing $script_path"
        bash "$script_path"
    fi
done

popd
