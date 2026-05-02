#!/bin/env bash

sudo apt-get install zsh -y

# I forgor if i need this
chmod 777 $HISTFILE
# chown user:group $HISTFILE # too lazy to use chown

# starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "Changing default shell to zsh"
chsh -s $(which zsh)
