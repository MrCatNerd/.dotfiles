#!/bin/env bash

DOTFILES_DIR="$PWD"

source $DOTFILES_DIR/common_bash/backup.sh

backup_file "$HOME/.vimrc"

ln -srf "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

