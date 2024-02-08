#!/bin/env bash

pushd /tmp

sudo apt install rofi -y

mkdir -p ~/.local/share/rofi/themes/

git clone https://github.com/lr-tech/rofi-themes-collection.git
cd rofi-themes-collection
cp themes/rounded-blue-dark.rasi ~/.local/share/rofi/themes/

popd

