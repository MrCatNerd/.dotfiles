#!/bin/bash

# Define the dotfiles directory path as the current working directory
DOTFILES_DIR="$PWD"

source $DOTFILES_DIR/common_bash/backup.sh

backup_file "$HOME/.bashrc"
backup_file "$HOME/.gitconfig"
backup_file "$HOME/.bash_aliases"
backup_file "$HOME/.profile"

ln -srf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
ln -srf "$DOTFILES_DIR/bash/.profile" "$HOME/.profile"
ln -srf "$DOTFILES_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"
ln -srf "$DOTFILES_DIR/bash/.bash_logout" "$HOME/.bash_logout"
