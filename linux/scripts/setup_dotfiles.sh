#!/bin/env bash

# Define the dotfiles directory path as the current working directory
DOTFILES_DIR="$PWD"

programs_setups=(
    "tmux"
    "bash"
    "zsh"
    "git"
    "kitty"
    "vim" # neovim btw
    # "alacritty" # i already use kitty
)

# Loop through programs_setups
for PROGRAM in "${programs_setups[@]}"; do
    echo Setting up "$PROGRAM"
    source "$DOTFILES_DIR/$PROGRAM/setup.sh"
    echo Finished setting up "$PROGRAM"
done

# chmod +x scripts/others.sh
# source scripts/others.sh
#
# chmod +x scripts/fonts.sh
# source scripts/fonts.sh

echo "Dotfiles setup complete!"

echo "Backup directory: $BACKUP_DIR"

