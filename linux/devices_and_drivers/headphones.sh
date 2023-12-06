#!/bin/bash

echo "WARNING: this script was created mainly for PopOS and my personal headphones and might not work for your system"
echo "WARNING: this script is still baking and it wont fix ur problems its just a mess for now"

echo "do: sudo apt remove pulseaudio if you want this thingy to work, at least i think so."

# Array of programs to check/install
echo "Installing tools for headphones:"

echo reinstalling pipewire
sudo apt-get reinstall -y libpipewire-0.3-0 libpipewire-0.3-common libpipewire-0.3-modules pipewire pipewire-audio-client-libraries pipewire-bin pipewire-pulse

programs=( # TODO: reimplement check install thingy with apt
    "pavucontrol"
    "alsa-base"
    "alsa-utils"
    "wireplumber"
    "pipewire-alsa"
    "pipewire-pulse"
    "pipewire-jack"
    "jackd2"
    "alsa-firmware-loaders"
    # "qjackctl"
    # "pipewire-media-session" might need it if not on pop: https://www.maketecheasier.com/install-configure-pipewire-linux/
)

# Loop through each program in the array
for name in "${programs[@]}"; do
    # Check if the program is installed
    if ! command -v "$name" &> /dev/null; then
        echo "$name not installed"
        # Install the program
        sudo apt-get install -y "$name"
    else
        echo "$name already installed"
    fi
done

# Update package list
echo "Updating package list..."
sudo apt-get update

# helpful stuff:
# https://www.reddit.com/r/pop_os/comments/uix809/guide_to_improve_audio_quality_on_pop_os_2204/
# https://support.system76.com/articles/audio/

echo "Starting configuration for JBL Quantum 100"

# Add your specific configurations for JBL Quantum 100 here if needed
# This may involve adjusting sound settings, configuring ALSA, etc.

# sudo mkdir /etc/pipewire/
# sudo cp /usr/share/pipewire/client.conf /etc/pipewire/
# sudo cp /usr/share/pipewire/pipewire-pulse.conf /etc/pipewire/
# systemctl --user stop pipewire-pulse.socket && systemctl --user stop pipewire-pulse.service
# systemctl --user start pipewire-pulse.socket && systemctl --user start pipewire-pulse.service
# If you would like to monitor PipeWire, run:
#pw-top

# This command will force reload the kernel sound driver modules
# sudo alsa force-reload
# sudo alsa reload # not forcing

# This command will check the status of PipeWire and show any errors if automatic restarts raised any errors
systemctl --user status pipewire

# echo removing pulseaudio and pipewire configs
# rm -r ~/.config/pulse/*
# rm -r ~/.local/state/wireplumber/*

# read in the article about this:
# sudo sed -i 's/--\["session.suspend-timeout-seconds"\] = 5/\["session.suspend-timeout-seconds"\] = 0/' /usr/share/wireplumber/main.lua.d/50-alsa-config.lua
# systemctl restart --user pipewire.service

# With hardware that uses the snd_hda_intel kernel module, rare bugs can cause the sound card to not be detected.
# If you're having this issue, try running these commands to force the usage of a specific audio driver (system76 article)

echo "options snd-hda-intel dmic_detect=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
echo "blacklist snd_soc_skl" | sudo tee -a /etc/modprobe.d/blacklist.conf

alsactl init # read here: https://www.maketecheasier.com/install-configure-pipewire-linux/

echo "Configuration completed for JBL Quantum 100"


# sudo apt-get install --reinstall pipewire pipewire-pulse
#
# idk why but putting on of the left / right balnacing thingy on higher power makes it sound good
# jackdbus-detect = false
