#!/bin/env bash

sudo apt install -y "build-essential"

programs=( # all of the programs that are here will not be installed by a different script
        # pop os may not have it by default
        # "vim-gtk3" # supports clipboard
        # "python3-pip"
        # "python3-venv"

        # just to make sure
        # "gcc"
        # "clang"
        # "curl"
        # "make"
        # "cmake"
        # "git"
        # "neovim" # cuz nix
        # install packages

        # work env
        # "fzy"
        "fzf"
        "ripgrep"

        # coding extras
        "nodejs_21"
        # "nodejs"
        # "npm"
        "sqlite"

        # others
        "stow"
        "nmap"
        # "hydra"
        "thc-hydra"
        "gimp"

        # maliciousness
        # "lolcat"
        # "tree"
        # "cmatrix"
        # "cava"
        "neofetch"
        "htop"
    )


for program in "${programs[@]}"; do
    # sudo apt install -y "$program"
    # install packges
    nix-env -iA nixpkgs."$program"
done
