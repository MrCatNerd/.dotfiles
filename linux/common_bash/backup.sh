#!/bin/bash

# Define the dotfiles directory path as the current working directory
BACKUP_DIR="$HOME/backup"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to create backups
backup_file() {
    local file="$1"
    local backup_file="$BACKUP_DIR/$(basename "$file").backup"

    if [ -f "$file" ] || [ -L "$file" ]; then
        echo "Backing up $file to $backup_file"
        cp -R "$file" "$backup_file"
    fi
}

