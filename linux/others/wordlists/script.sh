#!/bin/bash

CURRENT_WORKING_DIR=$PWD
WORDLIST_NAME="Rockyou"

# Check if wpa2-wordlists directory exists or clone it
if [ ! -d "wpa2-wordlists" ]; then  # Check if the directory 'wpa2-wordlists' exists
    git clone https://github.com/kennyn510/wpa2-wordlists.git --depth=1  # Clone the repository if the directory doesn't exist
else
    echo "'wpa2-wordlists' directory already exists. Skipping cloning."
fi

# Change directory to the Rockyou wordlist directory
cd wpa2-wordlists/Wordlists/$WORDLIST_NAME

# Concatenate .txt files into a single file and save in wordlists directory
mkdir -p wordlists
sudo cat *.txt >> $CURRENT_WORKING_DIR/wordlists/$WORDLIST_NAME.txt

# Change back to the original working directory
cd $CURRENT_WORKING_DIR

