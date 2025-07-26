#!/bin/env bash

sudo apt-get -y install pipx ninja-build
pipx install meson
sudo pipx install meson

mkdir -p "$HOME/Documents/Code/Gitting"
pushd "$HOME/Documents/Code/Gitting"
git clone --depth 1 "https://github.com/mpv-player/mpv-build.git" "mpv-build"
popd
pushd "$HOME/Documents/Code/Gitting/mpv-build"
printf "%s\n" -Dlibmpv=true > mpv_options
./clean
./use-mpv-master
./clean
./update
printf "%s\n" --enable-nonfree    >> ffmpeg_options
printf "%s\n" -Dlibmpv=true > mpv_options
./rebuild -j"$(nproc)"
sudo ./install
popd
