#!/bin/env bash

echo "Preparing stuff for 02"

yes | sudo dpkg --add-architecture i386
sudo apt update

cat <<EOF | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF

echo "Please reboot before running 02-setup.sh!!!"
