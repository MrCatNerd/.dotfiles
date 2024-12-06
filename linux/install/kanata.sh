#!/bin/env bash

git clone https://github.com/jtroo/kanata /tmp/kanata
pushd /tmp/kanata
cargo build --release

# sudo is used because kanata opens /dev/ files
#
# See below if you want to avoid needing sudo:
# https://github.com/jtroo/kanata/wiki/Avoid-using-sudo-on-Linux
sudo cp target/release/kanata /usr/local/bin
# sudo target/release/kanata --cfg <your_configuration_file>
popd
