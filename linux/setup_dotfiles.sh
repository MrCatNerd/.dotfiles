#!/bin/bash

# Define the dotfiles directory path
DOTFILES_DIR="/path/to/dotfiles"

# Function to create backups
backup_file() {
    if [ -f "$1" ] || [ -L "$1" ]; then
        echo "Backing up $1 to $1.backup"
        mv "$1" "$1.backup"
    fi
}

# Create backups for existing dotfiles
backup_file ~/.bashrc
backup_file ~/.vimrc
# backup_file ~/.gitconfig

# Create symbolic links for dotfiles
ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc
# ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig

echo "Dotfiles setup complete!"

