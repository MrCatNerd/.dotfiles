#!/bin/env bash

# install the .NET runtime (when you upgrade check if you need a newer runtime)
sudo apt-get -y install dotnet-runtime-8.0

# download the OpenTabletDriver package
curl -sSfL -o "/tmp/OpenTabletDriver.deb" "https://github.com/OpenTabletDriver/OpenTabletDriver/releases/download/v0.6.7/opentabletdriver_0.6.7-1_x64.deb"

# install the OpenTabletDriver package
sudo dpkg -i /tmp/OpenTabletDriver.deb

# fix any missing dependencies after the installation
sudo apt-get install -f -y

# enable and start the OpenTabletDriver service type shi
systemctl --user enable opentabletdriver.service --now
