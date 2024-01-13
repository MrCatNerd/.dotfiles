#!/usr/bin/env zsh

sudo apt install stow -y
if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="bin,tmux,zsh,bash,vim,git,kitty"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles/linux/
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/linux/install.zsh
