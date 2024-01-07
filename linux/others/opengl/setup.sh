#!/bin/env bash

# ANSI color escape codes for different colors
RED='\033[0;31m'       # Red color
NC='\033[0m'           # No Color

# Echoing the URL with colored text
printf "${RED}https://medium.com/geekculture/a-beginners-guide-to-setup-opengl-in-linux-debian-2bfe02ccd1e${NC}\n"

# Rest of your script remains unchanged...
CURRENT_DIR="$PWD"

sudo apt-get update -y
sudo apt-get install -y cmake pkg-config
sudo apt-get install -y mesa-utils libglu1-mesa-dev freeglut3-dev mesa-common-dev
sudo apt-get install -y libglew-dev libglfw3-dev libglm-dev
sudo apt-get install -y libao-dev libmpg123-dev

echo Installing GLFW
cd /usr/local/lib/ -s
sudo git clone https://github.com/glfw/glfw.git
cd glfw -s
sudo cmake .
sudo make
sudo make install

# Printing formatted clickable links with colored text in Kitty terminal
printf "${RED}\e]8;;https://medium.com/geekculture/a-beginners-guide-to-setup-opengl-in-linux-debian-2bfe02ccd1e\aMedium Guide${NC}\e]8;;\a\n"
printf "${RED}\e]8;;https://github.com/glfw/glfw.git\aGLFW Github${NC}\e]8;;\a\n"
printf "${RED}\e]8;;https://glad.dav1d.de/#language=c&specification=gl&api=gl%%3D4.6&api=gles1%%3Dnone&api=gles2%%3Dnone&api=glsc2%%3Dnone&profile=core&loader=on\aGlad Installation permalink${NC}\e]8;;\a\n"

cd "$CURRENT_DIR"

