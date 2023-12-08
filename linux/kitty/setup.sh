#!/bin/bash

# Check if the current directory ends with 'dotfiles/linux'
if [[ ! "$PWD" = *"dotfiles/linux" ]]; then
    echo "Current directory should end with dotfiles/linux"
    exit 1
fi

# Define variables
KITTY_DOTFILES_DIR="$PWD/kitty"
DOTFILES_DIR="$PWD"

echo Creating backups
# Get backup function
source $DOTFILES_DIR/common_bash/backup.sh

# Backup existing files (assuming your backup function is named backup_file)
backup_file "$HOME/.config/kitty/"

echo Installing themes
THEME=https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/Dracula.conf
wget "$THEME" -P $HOME/.config/kitty/kitty-themes/themes
ln -s $HOME/.config/kitty/kitty-themes/themes/Dracula.conf $HOME/.config/kitty/theme.conf


# Create symbolic links
mkdir -p $HOME/.config/kitty/
ln -srf "$KITTY_DOTFILES_DIR/kitty.conf" "$HOME/.config/kitty/kitty.conf"

echo "Setup completed successfully."


