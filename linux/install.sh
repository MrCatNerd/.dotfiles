#!/usr/bin/env bash

pushd "$DOTFILES"

bash "./install/general.sh"
bash "./install/git.sh"

for folder in $(echo "$STOW_FOLDERS" | sed "s/,/ /g")
do
    echo "stow $folder"
    stow -D "$folder"
    stow "$folder"

    script_path="./install/$folder.sh"

    if [ -f "$script_path" ]; then
        echo "Executing $script_path"
        bash "$script_path"
    else
        echo "$script_path doesn't exist"
    fi
done

popd
