#!/bin/env bash

echo "This script will autorun things that I use"

echo "Installing NerdFonts"
source "fonts.sh"

echo "Installing compilers and programming languages"
# source "programming_languages/mysql.sh"
source "programming_languages/clang.sh"
source "programming_languages/go.sh"
source "programming_languages/rust.sh"

