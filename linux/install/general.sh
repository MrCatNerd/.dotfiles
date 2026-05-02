#!/bin/env bash

# will be executed first

programs=(
    # general stuff
    "gimp"
    "curl"
    "wine"

    # work env
    "build-essential"
    "autoconf"
    "automake"
    "libtool"
    "cloc"
    "fzf"
    #"fzy"
    "ripgrep"
    "sqlite"
    "valgrind"

    # manual pages
    "man-db"
    "manpages-dev"
    "manpages-posix"
    "manpages-posix-dev"

    # misc
    # "lolcat"
    # "screenkey"
    "tree"
    "cmatrix"
    "cava"
    "fastfetch"
    "htop"
)


for program in "${programs[@]}"; do
    # install packges
    sudo apt-get install -y "$program"
done

# I don't know why I put that here lol
sudo locale-gen en_US.UTF-8
