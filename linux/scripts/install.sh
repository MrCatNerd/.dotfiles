#!/usr/bin/env bash

set -e

pushd ansible
echo "Ansiable go bRRR"
# install requirements
ansible-galaxy install -r requirements.yml

# run the playbook
ansible-playbook --ask-become-pass playbooks/bootstrap.yml
popd


pushd config
STOW_FOLDERS=(git zsh tmux kitty)
for folder in "${STOW_FOLDERS[@]}"; do
    echo "stow $folder"
    stow -D "$folder"
    stow "$folder"
done
popd

echo "Rebooting is recommended!"
