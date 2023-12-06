#!/bin/bash

# Check if the current directory ends with 'dotfiles/linux'
if [[ ! "$PWD" = *"dotfiles/linux" ]]; then
    echo "Current directory should end with dotfiles/linux"
    exit 1
fi

# Define variables
ZSH_DOTFILES_DIR="$PWD/zsh"

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Assuming you have the backup functionality elsewhere

# get backup function
source $ZSH_DOTFILES_DIR/common_bash/backup.sh

# Backup existing files (assuming your backup function is named backup_file)
backup_file "$HOME/.zshrc"
backup_file "$HOME/.zprofile"
backup_file "$HOME/.zsh_aliases"

# Create symbolic links
ln -srf "$ZSH_DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -srf "$ZSH_DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -srf "$ZSH_DOTFILES_DIR/.zsh_aliases" "$HOME/.zsh_aliases"

echo "Setup completed successfully."

