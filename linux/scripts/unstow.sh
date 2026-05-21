#!/usr/bin/env bash

set -e

pushd config
STOW_FOLDERS=(git zsh tmux kitty)
for folder in "${STOW_FOLDERS[@]}"; do
    echo "stow -D $folder"
    stow -D "$folder"
done
popd
