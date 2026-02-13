#!/bin/env bash

curl -sSfL -o "/tmp/OpenTabletDriver.deb" "https://github.com/OpenTabletDriver/OpenTabletDriver/releases/download/v0.6.6.2/opentabletdriver-0.6.6.2-1-x64.deb"
sudo dpkg -i /tmp/OpenTabletDriver.deb
systemctl --user enable opentabletdriver.service --now
