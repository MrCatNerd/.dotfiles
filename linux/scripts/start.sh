#!/bin/bash

echo WARNING: this script was created mainly for PopOS and might not work for your system

# Array of programs to check/install
echo "Installing tools:"
programs=(
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
        "alacritty"
        # or
        #kitty:
        #"kitty"
        #"imagemagick" # kitten +icat <image-path.png>
        # ---
        "fzf"
        "tmux"
        "zsh"

        # coding extras
        "ripgrep"
        "nodejs"
        "npm"
        "cmake"
        "sqlite3"

        # others
        "tree"
        "netcat"
        "neofetch"
        "nmap"

        # maliciousness
        # "lolcat"
    )

# Update package list
sudo apt-get update
sudo apt-get upgrade

# Loop through each program in the array
for name in "${programs[@]}"; do
    # Check if the program is installed
    if ! command -v "$name" &> /dev/null; then
        echo "$name is not installed"
        sudo apt-get install "$name" -y
    else
        echo "$name is already installed"
    fi
done

# Additional commands

chmod +x scripts/setup_dotfiles.sh
source scripts/setup_dotfiles.sh

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
