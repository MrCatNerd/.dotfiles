#!/bin/bash

# Define the dotfiles directory path as the current working directory
DOTFILES_DIR="$PWD"
BACKUP_DIR="$HOME/backup"

# Function to create backups
backup_file() {
    local file="$1"
    local backup_file="$BACKUP_DIR/$(basename "$file").backup"

    if [ -f "$file" ] || [ -L "$file" ]; then
        echo "Backing up $file to $backup_file"
        cp -R "$file" "$backup_file"
    fi
}

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create backups for existing dotfiles
backup_file "$HOME/.bashrc"
backup_file "$HOME/.vimrc"
backup_file "$HOME/.gitconfig"
backup_file "$HOME/.bash_aliases"
backup_file "$HOME/.profile"

backup_file "$HOME/.config/alacritty/"

# Create symbolic links for dotfiles
ln -srf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -srf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -srf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -srf "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases"
ln -srf "$DOTFILES_DIR/.profile" "$HOME/.profile"
ln -srf "$DOTFILES_DIR/.bash_logout" "$HOME/.bash_logout"

# ln -srf "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"
ln -srf "$DOTFILES_DIR/alacritty/" "$HOME/.config/"


echo "Dotfiles setup complete!"

echo "Backup directory: $BACKUP_DIR"

