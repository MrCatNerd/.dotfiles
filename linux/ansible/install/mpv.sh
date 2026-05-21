#!/bin/env bash

sudo apt-get -y install \
    "nasm" \
    "ninja-build" \
    "meson" \
    "build-essential" \
    "autoconf" \
    "automake" \
    "libfreetype6-dev" \
    "libfribidi-dev" \
    "libharfbuzz-dev" \
    "libfontconfig1-dev"


mkdir -p "$HOME/Documents/Code/Gitting"
git clone --depth 1 "https://github.com/mpv-player/mpv-build.git" "$HOME/Documents/Code/Gitting/mpv-build"
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
