#!/bin/env bash

# Function to check if the previous operation was successful
check_success() {
    if [ $? -ne 0 ]; then
        echo "$1. Aborting installation."
        exit 1
    fi
}

# Download glad.zip
curl -fsSL -o "/tmp/glad.zip" "https://glad.dav1d.de/generated/tmphhgk0opwglad/glad.zip" # TODO: get this automatically

# Check if the download was successful
check_success "Failed to download glad.zip. URL my be invalid, get a new one from the glad website to continue"

# Unzip glad.zip and copy files to /usr/include/
unzip -qq "/tmp/glad.zip" -d "/tmp/glad" \
&& sudo cp -R "/tmpglad/include/*" "/usr/include/"

# Check if the above process was successful
check_success "Error occurred during installation. Please ensure proper permissions and try again."

echo "Glad installation completed successfully."

