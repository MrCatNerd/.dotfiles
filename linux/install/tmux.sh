#!/bin/env bash

sudo apt install tmux -y

echo "Installing TPM"
git clone https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm

echo "Tmux setup completed successfully."


