#!/usr/bin/env bash

pushd "$DOTFILES"

bash "./install/general.sh"

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
