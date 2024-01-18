#!/bin/env bash

programs=( # all of the programs that are here will not be installed by a different script
        # pop os may not have it by default
        "vim-gtk3" # supports clipboard
        "python3-pip"
        "python3-venv"

        # just to make sure
        "gcc"
        "clang"
        "build-essential"
        "curl"
        "make"
        "cmake"
        "git"

        # work env
        # "fzy"
        "fzf"
        "ripgrep"

        # coding extras
        "nodejs"
        "npm"
        "sqlite3"

        # others
        "nmap"
        "hydra"
        "gimp"

        # maliciousness
        # "lolcat"
        # "tree"
        # "cmatrix"
        # "cava"
        "neofetch"
        "htop"
        "screenkey"
    )


for program in "${programs[@]}"; do
    sudo apt install -y "$program"
done
