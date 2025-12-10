#!/bin/env bash

sudo apt-get -y install pipx ninja-build nasm \
  libx264-dev libx265-dev libvpx-dev libaom-dev \
  libfdk-aac-dev libmp3lame-dev libopus-dev libvorbis-dev \
  libass-dev libfreetype6-dev libfontconfig1-dev libxml2-dev \
  zlib1g-dev liblzma-dev libzvbi-dev \
  libva-dev libva-drm2 libva-x11-2 vainfo \
  libdav1d-dev
pipx install meson

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
printf "%s\n" \
  --enable-gpl \
  --enable-nonfree \
  --enable-version3 \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libvpx \
  --enable-libaom \
  --enable-libdav1d \
  --enable-libfdk-aac \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libass \
  --enable-libfreetype \
  --enable-libfontconfig \
  --enable-libxml2 \
  --enable-zlib \
  --enable-lzma \
  --enable-libzvbi \
  --enable-vaapi \
> ffmpeg_options
printf "%s\n" -Dlibmpv=true > mpv_options
./rebuild -j"$(nproc)"
sudo ./install
popd
