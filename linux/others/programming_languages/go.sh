#!/bin/env bash

GO_VERSION="1.21.6"
curl -sSfL -o "/tmp/go$GO_VERSION.linux-amd64.tar.gz" "https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"

tar xvpf "/tmp/go$GO_VERSION.linux-amd64.tar.gz" -C "/tmp/"
sudo chown -R root:root "/tmp/go"

sudo mv "/tmp/go" "/usr/local/go"

printf "\nIf you're not using a custom shell configuration, add /usr/local/go/bin to your PATH:\n\n"

echo '# Add /usr/local/go/bin to PATH if it exists
[ -d "/usr/local/go/bin" ] && PATH="/usr/local/go/bin:$PATH"'


