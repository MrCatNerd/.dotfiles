#!/bin/env bash

sudo apt-get install zsh -y

# oh my zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

# set starship theme
starship preset pastel-powerline -o ~/.config/starship.toml

