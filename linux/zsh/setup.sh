#!/bin/bash

# Check if the current directory ends with 'dotfiles/linux'
if [[ ! "$PWD" = *"dotfiles/linux" ]]; then
    echo "Current directory should end with dotfiles/linux"
    exit 1
fi

# Define variables
ZSH_DOTFILES_DIR="$PWD/zsh"
DOTFILES_DIR="$PWD"

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo Installing the Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Get backup function
source $DOTFILES_DIR/common_bash/backup.sh

# Backup existing files (assuming your backup function is named backup_file)
backup_file "$HOME/.zshrc"
backup_file "$HOME/.zsh_aliases"
backup_file "$HOME/.p10k.zsh"

# Create symbolic links
ln -srf "$ZSH_DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -srf "$ZSH_DOTFILES_DIR/.zsh_aliases" "$HOME/.zsh_aliases"
ln -srf "$ZSH_DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

echo "Setup completed successfully."

