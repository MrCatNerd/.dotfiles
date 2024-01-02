#!/bin/bash


# POP OS!
echo "WARNING: this script was ment for PopOS (would maybe work on ubuntu)"

echo Autoinstalling drivers
sudo ubuntu-drivers autoinstall
echo Finished installing drivers

echo Linking nvidia settings to ~
ln -srf .nvidia-settings-rc ~/.nvidia-settings-rc
echo Finished linking nvidia settings to ~

echo "https://youtu.be/v9tb1gTTbJE"
echo "https://protondb.com"


