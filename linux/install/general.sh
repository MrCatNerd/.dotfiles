#!/bin/env bash

# will be executed first

programs=(
    # python stuff
    "python3-pip"
    "python3-venv"
    "pipx"

    # general stuff
    "gimp"
    "curl"
    "openvpn"
    "wine"

    # work env
    "bear"
    "build-essential"
    "cloc"
    "fzf"
    #"fzy"
    "hydra"
    "nmap"
    "ripgrep"
    "sqlite"
    "valgrind"

    # pop os may not have it by default
    # "vim-gtk3" # supports clipboard

    # manual pages
    "man-db"
    "manpages-dev"
    "manpages-posix"
    "manpages-posix-dev"

    # misc
    # "lolcat"
    "screenkey"
    "tree"
    "cmatrix"
    "cava"
    "neofetch"
    "htop"
)


for program in "${programs[@]}"; do
    # sudo apt install -y "$program"
    # install packges
    sudo apt-get install -y "$program"
done

sudo locale-gen en_US.UTF-8

sudo pipx ensurepath
