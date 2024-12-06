#!/bin/env bash

echo "Installing NerdFonts"
source "fonts.sh"

echo "Installing compilers and programming languages and stuff"
# source "programming_languages/mysql.sh"
source "programming_languages/clang.sh"
source "programming_languages/go.sh"
source "programming_languages/node.sh"
source "programming_languages/rust.sh"

echo "Installing Mingw"
source "mingw.sh"

echo "Installing docker"
source "docker.sh"

