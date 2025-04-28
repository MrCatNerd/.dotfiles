#!/usr/bin/env bash

pushd "$DOTFILES"

if [ -f "$script_path" ]; then
    echo "Executing ./install/nix.sh"
    bash "./install/nix.sh"
fi

bash "./install/apt.sh"
bash "./install/git.sh"

bash "./install/general.sh"

for folder in $(echo "$STOW_FOLDERS" | sed "s/,/ /g")
do
    # TODO: find out why stow is erroring but it still works and i got no idea why
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
