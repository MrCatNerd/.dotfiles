#!/usr/bin/env bash
if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="zsh,bash,vim,git,local_bin,kitty"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles/linux
fi

# install
# STOW_FOLDERS="$STOW_FOLDERS" DOTFILES="$DOTFILES" $DOTFILES/install.sh

# clean
STOW_FOLDERS="$STOW_FOLDERS" DOTFILES="$DOTFILES" $DOTFILES/clean-env.sh

