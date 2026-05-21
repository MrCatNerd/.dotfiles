#!/bin/env bash

# install git stuff
sudo apt install -y git git-lfs tig

# install diff-so-fancy
sudo curl -sSfL -o "/usr/local/bin/diff-so-fancy" "https://github.com/so-fancy/diff-so-fancy/releases/download/v1.4.4/diff-so-fancy"
sudo chmod +x "/usr/local/bin/diff-so-fancy"
