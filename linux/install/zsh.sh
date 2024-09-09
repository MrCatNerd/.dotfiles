#!/bin/env bash

sudo apt-get install zsh -y

# oh my zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# oh my zsh sets zsh history file to root
chmod 777 $HISTFILE
# chown user:group $HISTFILE # too lazy to use chown

# starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

# set starship theme
starship preset pastel-powerline -o ~/.config/starship.toml

