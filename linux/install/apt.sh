#!/bin/env bash

programs=(
    # outdated cuz stable release model
    # "nodejs"
    # "npm"

    "bear"
    "build-essential"
    "cloc"
    "gimp"
    "hydra"
    "nmap"
    "openvpn"
    "python3-pip"
    "python3-venv"
    "screenkey"
    "valgrind"
    "wine"
    "curl"

    # pop os may not have it by default
    # "vim-gtk3" # supports clipboard

    # manual pages
    "man-db"
    "manpages-dev"
    "manpages-posix"
    "manpages-posix-dev"
)


for program in "${programs[@]}"; do
    # sudo apt install -y "$program"
    # install packges
    sudo apt-get install -y "$program"
done
