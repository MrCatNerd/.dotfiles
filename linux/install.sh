#!/usr/bin/env bash

pushd "$DOTFILES"

bash "./install/general.sh"

echo "stow nix"
stow -D "nix"
stow "nix"

if [ -f "$script_path" ]; then
    echo "Executing ./install/nix.sh"
    bash "./install/nix.sh"
fi

for folder in $(echo "$STOW_FOLDERS" | sed "s/,/ /g")
do
    echo "stow $folder"
    stow -D "$folder" # TODO: find out why this is erroring but it still works and i got no idea why
    stow "$folder"

    script_path="./install/$folder.sh"

    if [ -f "$script_path" ]; then
        echo "Executing $script_path"
        bash "$script_path"
    fi
done

popd
