#!/bin/env bash

WORDLIST_NAME="Rockyou"

# Check if wpa2-wordlists directory exists or clone it
if [ ! -d "/tmp/wpa2-wordlists" ]; then
    git clone --depth=1 "https://github.com/kennyn510/wpa2-wordlists.git" "/tmp/wpa2-wordlists"
else
    echo "'/tmp/wpa2-wordlists' directory already exists. Skipping cloning."
fi

# Concatenate .txt files into a single file and save in wordlists directory
sudo mkdir -p "/usr/share/wordlists/"
for file in /tmp/wpa2-wordlists/Wordlists/"$WORDLIST_NAME"/*.txt; do
    sudo cat "$file" >> "/usr/share/wordlists/$WORDLIST_NAME.txt"
done

