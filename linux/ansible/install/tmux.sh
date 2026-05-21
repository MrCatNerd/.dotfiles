#!/bin/env bash

sudo apt-get install -y tmux

echo "Installing TPM"
git clone https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm

# install tmux-yank dependency
sudo apt-get install -y xclip

echo "Tmux setup completed successfully."


