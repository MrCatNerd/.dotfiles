#!/bin/env bash

sudo apt install kitty -y
# optional:
sudo apt install imagemagick -y # kitten +icat <image-path.png>

# Dracula
# THEME=https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/Dracula.conf
# wget "$THEME" -P $HOME/.config/kitty/kitty-themes/themes
# ln -s $HOME/.config/kitty/kitty-themes/themes/Dracula.conf $HOME/.config/kitty/theme.conf

# Rose-Pine
THEME="https://raw.githubusercontent.com/rose-pine/kitty/main/dist/rose-pine.conf"
mkdir -p "$HOME/.config/kitty/kitty-themes/theme/"
curl -sSfL -o "$HOME/.config/kitty/kitty-themes/theme/Rose-Pine.conf" "$THEME"
ln -sf "$HOME/.config/kitty/kitty-themes/theme/Rose-Pine.conf" "$HOME/.config/kitty/theme.conf"

