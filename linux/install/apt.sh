#!/bin/env bash

sudo apt install -y "build-essential"

programs=( # all of the programs that are here will not be installed by a different script
    # pop os may not have it by default
    # "vim-gtk3" # supports clipboard
    "python3-pip"
    "python3-venv"
    "nmap"
    "hydra"
    "valgrind"
    "cloc"
    "wine"
    "bear"
    "screenkey"
    "git"
    "git-lfs"
    "openvpn"
    "nodejs"
    "npm"

    # manual pages
    "man-db"
    "manpages-posix"
    "manpages-dev"
    "manpages-posix-dev"
)


for program in "${programs[@]}"; do
    # sudo apt install -y "$program"
    # install packges
    sudo apt-get install -y "$program"
done
