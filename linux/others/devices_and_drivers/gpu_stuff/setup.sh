#!/bin/env bash

# POP OS!
echo "WARNING: this script was ment for PopOS and if it aint working its your problem"

echo Autoinstalling drivers
sudo ubuntu-drivers autoinstall
echo Finished installing drivers

echo Linking nvidia settings to ~
ln -srf .nvidia-settings-rc $HOME/.nvidia-settings-rc # ik i can stow
echo Finished linking nvidia settings to ~

echo "https://youtu.be/v9tb1gTTbJE"
echo "https://protondb.com"


