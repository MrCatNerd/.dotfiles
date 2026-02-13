#!/bin/bash
# NOTE: this script isn't being ran automatically by other scripts,
# you should run this script manually via sudo

# fully disable Ubuntu telemetry and crash reporting
# Ubuntu's telemetry isn't really invasive or anything but I prefer it disabled

if [ "$(id -u)" -ne 0 ]; then
    echo "[-] Must be run as root"
    exit 1
fi

echo "[*] Updating package info..."
apt update -qq

echo "[*] Removing telemetry and crash packages..."
apt purge -y ubuntu-report popularity-contest apport whoopsie

echo "[*] Stopping and disabling apport service..."
systemctl stop apport.service 2>/dev/null
systemctl disable apport.service 2>/dev/null

echo "[*] Declining Ubuntu hardware survey..."
if command -v ubuntu-report >/dev/null 2>&1; then
    ubuntu-report disable 2>/dev/null
fi

echo "[+] Ubuntu telemetry disabled."
