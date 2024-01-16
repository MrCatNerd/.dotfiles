#!/usr/bin/env bash
if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="local_bin,tmux,zsh,bash,vim,git,kitty,nix"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

# install
STOW_FOLDERS="$STOW_FOLDERS" DOTFILES="$DOTFILES" $DOTFILES/linux/install.sh

# clean
#STOW_FOLDERS="$STOW_FOLDERS" DOTFILES="$DOTFILES" $DOTFILES/linux/clean-env.sh

