#!/bin/env bash

# bruh

sudo apt-get install -y cmake gcc build-essential pkg-config

git clone "https://github.com/fastfetch-cli/fastfetch.git" "/tmp/fastfetch" --depth 1
pushd /tmp/fastfetch
mkdir -p build
pushd build
cmake ..
cmake --build . --target fastfetch --target flashfetch
popd
cmake --install . --prefix /usr/local
popd

# sanity checks
which neofetch
neofetch --version
