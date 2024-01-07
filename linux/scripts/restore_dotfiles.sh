#!/bin/env bash

# TODO: make this work for everything :(

# Define the backup directory path
BACKUP_DIR="$HOME/backup"

# Function to restore backups
restore_file() {
    local file="$1"
    local backup_file="$BACKUP_DIR/$(basename "$file").backup"

    if [ -f "$backup_file" ]; then
        echo "Restoring $backup_file to $file"
        mv "$backup_file" "$file"
    else
        echo "Backup file not found for $file"
    fi
}

# Restore dotfiles from backups

# bash
restore_file "$HOME/.bashrc"
restore_file "$HOME/.bash_aliases"
restore_file "$HOME/.profile"
restore_file "$HOME/.bash_logout"

# vim
restore_file "$HOME/.vimrc"

# git
restore_file "$HOME/.gitconfig"

# alacritty
restore_file "$HOME/.config/alacritty"

echo "Dotfiles restored!"

