#!/bin/env bash


sudo apt-get -y install awesome rofi flameshot x11-xkb-utils alsa-utils playerctl i3lock pipx ninja-build

# Rofi themes stuff
mkdir -p "/usr/share/rofi/themes"

# Rofi themes collection
rm -rf "/tmp/rose-pine"
git clone "https://github.com/rose-pine/rofi.git" "/tmp/rose-pine" --depth=1

# Rose-Pine
sudo cp "/tmp/rose-pine/rose-pine-moon.rasi" "/usr/share/rofi/themes/rose-pine-moon.rasi"

# rm -rf "/tmp/rofi-themes-collection"
# git clone "https://github.com/lr-tech/rofi-themes-collection.git" "/tmp/rofi-themes-collection" --depth=1
# sudo cp "/tmp/rofi-themes-collection/themes/rounded-blue-dark.rasi" "/usr/share/rofi/themes/rounded-blue-dark.rasi"


# Built picom from source because THEY GOT ANIMATIONS YEA BOIIIIIII

# actually install picom
git clone "https://github.com/yshui/picom.git" "/tmp/picom" --depth=1

# install the build deps
sudo apt-get install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev ninja-build uthash-dev

# compile and install
pushd "/tmp/picom"
meson setup --buildtype=release build
meson compile -C build
sudo ninja install -C build
popd


# i3lock-color (a fork)
git clone https://github.com/Raymo111/i3lock-color.git /tmp/i3lock-color --depth=1

# install the build deps
sudo apt-get install -y autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev libgif-dev

# compile and install
pushd "/tmp/i3lock-color"
chmod +x ./install-i3lock-color.sh
./install-i3lock-color.sh
popd
