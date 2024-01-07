#!/bin/env bash

echo $DOTFILES_DIR

check_installed() {
    local package="$1"
    if dpkg-query -l | grep -q "ii  $package"; then
        return 0  # Package is installed
    else
        return 1  # Package is not installed
    fi
}

install_programs() {
    # Loop through each program in the arguments
    for name in "${@}"; do
        # Check if the program is installed
        if check_installed "$name"; then
            echo "$name is already installed"
        else
            echo "$name is not installed"
            sudo apt-get install "$name" -y
        fi
    done
}
