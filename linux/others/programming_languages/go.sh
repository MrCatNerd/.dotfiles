#!/bin/env bash

GO_VERSION="1.21.6"
curl -sSfL -o "/tmp/go$GO_VERSION.linux-amd64.tar.gz" "https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"

tar xvpf "/tmp/go$GO_VERSION.linux-amd64.tar.gz" -C "/tmp/"
sudo chown -R root:root "/tmp/go"

sudo mv "/tmp/go" "/usr/local/go"

