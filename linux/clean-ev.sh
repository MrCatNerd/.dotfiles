#!/usr/bin/env bash

pushd $DOTFILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo "Removing $folder"
    # stow -D $folder
done

if [ "$(dirs -c)" ]; then
    popd
fi
