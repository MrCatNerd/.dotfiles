#!/bin/env bash


sudo apt-get install awesome picom rofi -y

# Rofi themes stuff
mkdir -p "/usr/share/rofi/themes"

# Rose-Pine

# Rofi themes collection
rm -rf "/tmp/rose-pine"
git clone "https://github.com/rose-pine/rofi.git" "/tmp/rose-pine" --depth 1
sudo cp "/tmp/rose-pine/rose-pine-moon.rasi" "/usr/share/rofi/themes/rose-pine-moon.rasi"

# rm -rf "/tmp/rofi-themes-collection"
# git clone "https://github.com/lr-tech/rofi-themes-collection.git" "/tmp/rofi-themes-collection" --depth 1
# sudo cp "/tmp/rofi-themes-collection/themes/rounded-blue-dark.rasi" "/usr/share/rofi/themes/rounded-blue-dark.rasi"

# TODO: keyboard
# setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll dvorak,il
# setxkbmap -option grp:switch,grp:super_space_toggle,grp_led:scroll dvorak,il

