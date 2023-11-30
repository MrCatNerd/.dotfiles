#!/bin/bash

# Array of programs to check/install
echo "Installing tools:"
programs=(
        # pop os doesnt have it by default
        # "vim-gtk3", # supports clipboard
        # "python3-pip"


        "alacritty",
        "fzf",
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

# if not installed:
# sudo dnf install libnotify
notify-send dotfiles done!
