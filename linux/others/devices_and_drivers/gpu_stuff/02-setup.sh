#!/bin/env bash

echo "Installing nvidia 470 driver + patches"

git clone "https://github.com/joanbm/nvidia-470xx-linux-mainline.git" "~/nvidia-470xx-linux-mainline"
pushd "~/nvidia-470xx-linux-mainline"
./install
popd

echo "Reboot again pls !"
