#!/bin/env bash

programs=( # all of the programs that are here will not be installed by a different script
        # work env
        # "fzy"
        "fzf"
        "ripgrep"

        # coding extras
        "sqlite"

        # others
        "stow"

        # maliciousness
        # "lolcat"
        # "tree"
        # "cmatrix"
        # "cava"
        "neofetch"
        "htop"
    )


for program in "${programs[@]}"; do
    sudo apt install -y "$program"
    # install packges
    # nix-env -iA nixpkgs."$program"
done

sudo locale-gen en_US.UTF-8

