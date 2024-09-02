#!/bin/env bash

curl -sSfL -o "/tmp/OpenTabletDriver.deb" "https://github.com/OpenTabletDriver/OpenTabletDriver/releases/latest/download/OpenTabletDriver.deb"
sudo dpkg -i /tmp/OpenTabletDriver.deb
systemctl --user enable opentabletdriver.service --now
