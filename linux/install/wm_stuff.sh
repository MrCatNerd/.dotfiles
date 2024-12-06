#!/bin/env bash


sudo apt-get -y install awesome rofi flameshot x11-xkb-utils alsa-utils playerctl i3lock


# Rofi themes stuff
mkdir -p "/usr/share/rofi/themes"

# Rose-Pine

# Rofi themes collection
rm -rf "/tmp/rose-pine"
git clone "https://github.com/rose-pine/rofi.git" "/tmp/rose-pine" --depth=1
sudo cp "/tmp/rose-pine/rose-pine-moon.rasi" "/usr/share/rofi/themes/rose-pine-moon.rasi"

# rm -rf "/tmp/rofi-themes-collection"
# git clone "https://github.com/lr-tech/rofi-themes-collection.git" "/tmp/rofi-themes-collection" --depth=1
# sudo cp "/tmp/rofi-themes-collection/themes/rounded-blue-dark.rasi" "/usr/share/rofi/themes/rounded-blue-dark.rasi"


# Built picom from source because THEY GOT ANIMATIONS YEA BOIIIIIII
# ill change it to apt install when they update the apt repo to support the animations

# install the build deps
sudo apt-get install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev
sudo apt-get install -y meson ninja-build

# acutally install picom
git clone "https://github.com/yshui/picom.git" "/tmp/picom" --depth=1
pushd "/tmp/picom"
meson setup --buildtype=release build
sudo ninja -C build install
popd

# i3lock-color (a fork)
sudo apt-get install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y
git clone https://github.com/Raymo111/i3lock-color.git /tmp/i3lock-color --depth=1
pushd /tmp/i3lock-color
./install-i3lock-color.sh
popd
