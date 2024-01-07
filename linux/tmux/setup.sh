#!/bin/env bash

# Check if the current directory ends with 'dotfiles/linux'
if [[ ! "$PWD" = *"dotfiles/linux" ]]; then
    echo "Current directory should end with dotfiles/linux"
    exit 1
fi

sudo apt install tmux -y

# Define variables
TMUX_DOTFILES_DIR="$PWD/tmux"
DOTFILES_DIR="$PWD"

echo "Installing TPM"
git clone https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm

# Get backup function
source $DOTFILES_DIR/common_bash/backup.sh

mkdir -p "$HOME/.config/tmux/"

# Backup existing files (assuming your backup function is named backup_file)
backup_file "$HOME/.config/tmux/tmux.conf"

# Create symbolic links
ln -srf "$TMUX_DOTFILES_DIR/tmux.conf" "$HOME/.config/tmux/tmux.conf"

echo "Tmux setup completed successfully."


