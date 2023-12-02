#!/bin/bash

echo WARNING: this script was created mainly for PopOS and might not be suited for your system

# Array of programs to check/install
echo "Installing tools:"
programs=(
        # pop os may not have it by default
        "vim-gtk3", # supports clipboard
        "python3-pip",
        "build-essential",


        # work env
        "alacritty",
        "fzf",
        "tmux",

        # extras
        "ripgrep",
        "nodejs",
        "npm"
        "cmake",
    )

# Update package list
sudo apt-get update

# Loop through each program in the array
for name in "${programs[@]}"; do
    # Check if the program is installed
    if ! command -v "$name" &> /dev/null; then
        echo "$name not installed"
        # Install the program
        sudo apt-get install -y "$name"
    else
        echo "$name already installed"
    fi
done

# Additional commands
chmod +x setup_dotfiles.sh
./setup_dotfiles.sh

echo "autoremoving unnecessary packages (apt-get autoremove)"
sudo apt-get autoremove

# if not installed:
# sudo apt-get install libnotify
notify-send dotfiles done!
