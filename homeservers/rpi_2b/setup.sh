#!/bin/env bash

echo "Updating system"
sudo apt-get update && sudo apt-get full-upgrade -y
echo "Updating system - done"

echo "Installing docker"
# Install docker for rpi: https://docs.docker.com/engine/install/raspberry-pi-os/

# uninstall unofficial packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get -y remove $pkg; done

# https://docs.docker.com/engine/install/raspberry-pi-os/#uninstall-docker-engine
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/raspbian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/raspbian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo apt-get autoremove -y

echo "Enabling docker on systemctl"
sudo systemctl enable docker
echo "Enabling docker on systemctl - done"

echo "Running docker sanity checks"
which docker 
docker --version
docker compose version

sudo docker run hello-world
echo "Running docker sanity checks - done"

echo "Installing docker - done"

echo "Enabling NetworkManager"
sudo systemctl enable NetworkManager
echo "Enabling NetworkManager - done"

echo "Installing neofetch"
./too_lazy_to_check_disk_usage_like_a_normal_person_lol.sh
echo "Installing neofetch - done"

# i forgor why i need this lol
echo "Installing dnsutils"
sudo apt-get install dnsutls dnsutils -y
echo "Installing dnsutils - done"
