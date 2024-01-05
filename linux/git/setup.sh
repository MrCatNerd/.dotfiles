#!/bin/bash

# Define the dotfiles directory path as the current working directory
DOTFILES_DIR="$PWD"

source $DOTFILES_DIR/common_bash/backup.sh

backup_file "$HOME/.gitconfig"

# git
ln -srf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
