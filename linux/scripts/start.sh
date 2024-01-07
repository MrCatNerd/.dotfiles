#!/bin/env bash

echo WARNING: this script was created mainly for PopOS and might not work for your system

find . -type f -name "*.sh" -exec chmod +x {} \; # i Am SuRe ThAtS sAfE

DOTFILES_DIR="$PWD"
source $DOTFILES_DIR/common_bash/install.sh

# Update package list
sudo apt-get update -y
sudo apt-get upgrade -y

# Array of programs to check/install
echo "Installing tools:"
programs=( # all of the programs that are here will not be installed by a different script
        # pop os may not have it by default
        # "vim-gtk3" # supports clipboard
        "python3-pip"
        "python3-venv"

        # just to make sure
        "gcc"
        "build-essential"
        "curl"
        "make"
        "cmake"

        # work env
        # "fzy"
        "fzf"
        "ripgrep"

        # coding extras
        "nodejs"
        "npm"
        "sqlite3"

        # others
        "nmap"
        "hydra"
        # "gimp"

        # maliciousness
        # "lolcat"
        # "tree"
        "neofetch"
        "htop"
        "screenkey"
    )

install_programs "${programs[@]}"

# Additional commands

# source scripts/setup_dotfiles.sh

echo "Cleaning stuff apt stuff up"
sudo apt-get --fix-broken install -y
sudo apt-get autoremove -y
sudo apt-get clean -y
sudo apt-get autoclean -y
# sudo dpkg --configure -a
echo "Finished cleaning stuff apt stuff up"


# if not installed:
# sudo apt-get install libnotify
notify-send dotfiles done!

# note: sudo apt-get install build-essential linux-headers-`uname -r` alsa-base alsa-firmware-loaders alsa-oss alsa-source alsa-tools alsa-tools-gui alsa-utils alsamixergui
