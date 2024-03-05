#!/usr/bin/env bash

sudo apt-get -y update
sudo apt-get -y upgrade
yes | sudo add-apt-repository universe

sudo apt-get install -y stow

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="clangd,zsh,bash,vim,git,local_bin,kitty,wm_stuff,wallpapers,neovim" # nix is automatically added
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles/linux
fi

# install
STOW_FOLDERS="$STOW_FOLDERS" DOTFILES="$DOTFILES" $DOTFILES/install.sh

pushd others
./autorun.sh
popd

sudo apt autoremove -y

# clean
# STOW_FOLDERS="$STOW_FOLDERS" DOTFILES="$DOTFILES" $DOTFILES/clean-env.sh

