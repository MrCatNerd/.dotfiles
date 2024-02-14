#!/bin/env bash

# Download Neovim AppImage to /tmp/ with a default filename
curl -Lso /tmp/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

# Make the downloaded file executable
chmod +x /tmp/nvim.appimage

# Move the executable to /usr/local/bin
sudo mv /tmp/nvim.appimage /usr/local/bin/nvim

