#!/bin/env bash

echo "cp ./.env ./.env.backup"
cp ./.env ./.env.backup

# Set up .env file with necessary configuration
cat <<EOL > .env
# General
HOMESERVER_LOCAL_IP=192.168.0.0
CONFIG_PATH=$HOME/.docker-server-stuff
MEDIA_PATH=/media/$USER/jellyfin
PGID=1000
PUID=1000
TZ=Etc/UTC

# PROTON VPN
DNS_ADDRESS=Interface_DNS  # DNS address for ProtonVPN
ENDPOINT_IP=PEER_ENDPOINT_IP  # The endpoint IP address of the VPN server (without the :port)
WIREGUARD_ADDR=Interface_Address  # The WireGuard interface address
PRIVATE_KEY=Interface_PrivateKey  # Your private key
PUBLIC_KEY=PEER_PublicKey  # The public key of the other peer
NAT_PMP=NAT-PMP # Port Forwarding (on/off)
ENDPOINT_PORT=51820  # Default port for ProtonVPN
EOL

echo "Configuration file .env have been set up."

