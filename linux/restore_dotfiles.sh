#!/bin/bash

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
restore_file ~/.bashrc
restore_file ~/.vimrc
restore_file ~/.gitconfig

echo "Dotfiles restored!"

