#!/bin/bash

# Error handling
set -euo pipefail

# Downloading Godot
echo "TODO: get latest release automatically"

# TODO: latest thingy
# # Fetching the latest release information from GitHub API
# latest_release=$(curl -s "https://api.github.com/repos/godotengine/godot/releases/latest")
# echo "$latest_release" | jq -r '.tarball_url'

wget "https://github.com/godotengine/godot/releases/download/4.2.1-stable/Godot_v4.2.1-stable_linux.x86_64.zip" -O "/tmp/godot.zip"

# Extracting Godot
sudo unzip -o "/tmp/godot.zip" -d "/usr/local/bin/"
sudo mv "/usr/local/bin/Godot_v4.2.1-stable_linux.x86_64" "/usr/local/bin/godot-engine"
sudo chmod a+x /usr/local/bin/godot-engine
echo "Godot successfully installed in /usr/local/bin"

# Verify if /usr/local/bin is in the PATH
if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    echo "WARNING: /usr/local/bin is not in PATH"
fi

