#!/usr/bin/env bash

# Create the local bin directory if it doesn't exist
mkdir -p "$HOME/.local/bin/"

find "$PWD" -type f -name "*.sh" -exec chmod +x {} +

# # Copy scripts to local bin
# cp -u "tmux-sessionizer.sh" "$HOME/.local/bin/"

ln -srf "$PWD/bin/tmux-sessionizer.sh" "$HOME/.local/bin/tmux-sessionizer.sh"


