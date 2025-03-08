#!/bin/bash

echo "Backupped old daemon.json to ~/backups!"
mkdir -p ~/backups
sudo cp /etc/docker/daemon.json ~/backups/daemon.json

echo "Moving new daemon.json"
sudo cp daemon.json /etc/docker/daemon.json
echo "Moving new daemon.json - done"
