#!/bin/env bash

echo "WARNING: this script may not work on your system (PopOS btw)"

# Install themes

THEME_URL=""
THEME="candy-icons"

ICON_THEME_URL=""
ICON_THEME="candy-icons"

mkdir -p themes

# /usr/share/icons/
# /usr/share/themes/

curl -fsSL -o themes/$THEME.tar.xz
tar -xf themes/$THEME.tar.xz -C themes
# tar -xf themes/$THEME.tar.xz /usr/share/icons/


mkdir -p $HOME/.themes
# pushd $HOME/.themes
# popd
gsettings set org.gnome.desktop.interface gtk-theme "pop-dark"
gsettings set org.gnome.desktop.wm.preferences theme "pop-dark"

mkdir -p $HOME/.icons
# pushd $HOME/.icons
# popd
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"

gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

