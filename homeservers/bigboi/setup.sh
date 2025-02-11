#!/bin/env bash

# Ensure $USER is set at the start
echo "- Ensuring \$USER"
echo "> export USER=$(whoami)"
export USER=$(whoami)

echo "Ensuring docker group stuff"
sudo groupadd docker
sudo usermod -aG docker $USER
# start a new session with a docker group
# newgrp docker
# exit to exit back
# exec su -l $USER

echo "- making directories"
echo "> sudo mkdir -p /home/${USER}/.docker-server-stuff"
echo "> sudo mkdir -p /media/${USER}/jellyfin/jellyfin/tvshows"
echo "> sudo mkdir -p /media/${USER}/jellyfin/jellyfin/movies"
sudo mkdir -p /home/${USER}/.jellyfin-config
sudo mkdir -p /media/${USER}/jellyfin/jellyfin/tvshows
sudo mkdir -p /media/${USER}/jellyfin/jellyfin/movies

echo "> sudo chown -R 1000:1000 /home/${USER}/.docker-server-stuff"
echo "> sudo chown -R 1000:1000 /media/${USER}/jellyfin"
sudo chown -R 1000:1000 /home/${USER}/.jellyfin-config
sudo chown -R 1000:1000 /media/${USER}/jellyfin/jellyfin

echo "> sudo chmod -R 755 /media/${USER}/jellyfin"
sudo chmod -R 755 /media/${USER}/jellyfin/jellyfin

echo "- allowing ports"
echo "> sudo ufw allow 8096"
sudo ufw allow 8096
echo "> sudo ufw allow 8920"
sudo ufw allow 8920
echo "> sudo ufw allow 7359/udp"
sudo ufw allow 7359/udp
echo "> sudo ufw allow 1900/udp"
sudo ufw allow 1900/udp
echo "> sudo ufw allow 8989"
sudo ufw allow 8989
echo "> sudo ufw allow 7878"
sudo ufw allow 7878
echo "> sudo ufw allow 9696"
sudo ufw allow 9696
echo "> sudo ufw allow 9117"
sudo ufw allow 9117
echo "> sudo ufw allow 9124"
sudo ufw allow 9124

echo "- setting up docker gpu support thingy (nvidia)"
echo "> sudo usermod -aG video $USER"
sudo usermod -aG video $USER
echo "> sudo apt install nvidia-container-toolkit nfs-common -y"
sudo apt install nvidia-container-toolkit nfs-common -y

echo "> sudo cp /etc/docker/daemon.json /etc/docker/daemon.backup"
sudo cp /etc/docker/daemon.json /etc/docker/daemon.backup

echo '{
    "data-root": "/var/lib/docker",
    "runtimes": {
        "nvidia": {
            "args": [],
            "path": "nvidia-container-runtime"
        }
    }
}' | sudo tee /etc/docker/daemon.json > /dev/null


echo "- done"
echo "- a restart is recommended"

