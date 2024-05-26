#!/bin/env bash

### Install kitty

# nix-env -iA \
#     nixpkgs.kitty \
#     nixpkgs.imagemagick # kitten +icat <image-path.png>
sudo apt-get install -y kitty imagemagick

### Declare variables
KITTY_CONFIG_DIR="$HOME/.config/kitty"
THEMES_DIR="$KITTY_CONFIG_DIR/kitty-themes"

# Create the theme directory
mkdir -p "$THEMES_DIR"

### Install all themes

# Dracula
THEME=https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/Dracula.conf
curl -sSfL -o "$THEMES_DIR/dracula.conf" "$THEME"

# Rose-Pine
THEME="https://raw.githubusercontent.com/rose-pine/kitty/main/dist/rose-pine.conf"
curl -sSfL -o "$THEMES_DIR/rose_pine.conf" "$THEME"

# Gruvbox
THEME="https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/gruvbox_dark.conf"
curl -sSfl -o "$THEMES_DIR/gruvbox_dark.conf" "$THEME"

### Link the one you want to choose
# CHOSEN_THEME="gruvbox_dark"
CHOSEN_THEME="rose_pine"
ln -sf "$THEMES_DIR/$CHOSEN_THEME.conf" "$KITTY_CONFIG_DIR/theme.conf"
