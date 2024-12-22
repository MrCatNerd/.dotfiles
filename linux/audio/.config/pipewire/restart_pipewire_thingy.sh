#!/bin/env bash

echo "restarting pipewire and pipewire-pulse daemons on user mode with systemctl..."
systemctl --user restart pipewire pipewire-pulse
echo "done"
