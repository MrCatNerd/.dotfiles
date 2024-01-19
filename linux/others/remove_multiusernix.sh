#!/bin/env bash

sudo systemctl stop nix-daemon.service
sudo systemctl disable nix-daemon.socket nix-daemon.service
sudo systemctl daemon-reload

sudo rm -rf /etc/nix /etc/profile.d/nix.sh /etc/tmpfiles.d/nix-daemon.conf /nix ~root/.nix-channels ~root/.nix-defexpr ~root/.nix-profile

for i in $(seq 1 32); do
  sudo userdel nixbld$i
done
sudo groupdel nixbld

printf "There may also be references to Nix in
    /etc/bash.bashrc
    /etc/bashrc
    /etc/profile
    /etc/zsh/zshrc
    /etc/zshrc
"

