#!/bin/env bash

echo "WARNING: i just copied stuff from the internet lol"
sudo apt-get install -y pkg-config

wget -qO vcpkg.tar.gz https://github.com/microsoft/vcpkg/archive/master.tar.gz
sudo mkdir /opt/vcpkg
sudo tar xf vcpkg.tar.gz --strip-components=1 -C /opt/vcpkg
sudo /opt/vcpkg/bootstrap-vcpkg.sh
sudo ln -s /opt/vcpkg/vcpkg /usr/local/bin/vcpkg
rm -rf vcpkg.tar.gz
