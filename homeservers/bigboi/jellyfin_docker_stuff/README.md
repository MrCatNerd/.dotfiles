# Jellyfin docker setup

inspired by: [Morzomb/All-jellyfin-media-server](https://github.com/Morzomb/All-jellyfin-media-server) and [AdrienPoupa/docker-compose-nas](https://github.com/AdrienPoupa/docker-compose-nas)

> [!WARNING]
> NVIDIA only cuz docker stuff but u can change it

| **Application**                                                    | **Description**                                                                                                                                      | **Image**                                                                                | **URL**       |
|--------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|---------------|
| [Jellyfin](https://jellyfin.org)                                   | Media server designed to organize, manage, and share digital media files to networked devices                                                        | [linuxserver/jellyfin](https://hub.docker.com/r/linuxserver/jellyfin)                    | /jellyfin     |
| [Jellyseer](https://jellyfin.org)                                  | Manages requests for your media library                                                                                                              | [fallenbagel/jellyseerr](https://hub.docker.com/r/fallenbagel/jellyseerr)                | /jellyseer    |
| [Sonarr](https://sonarr.tv)                                        | PVR for newsgroup and bittorrent users                                                                                                               | [linuxserver/sonarr](https://hub.docker.com/r/linuxserver/sonarr)                        | /sonarr       |
| [Radarr](https://radarr.video)                                     | Movie collection manager for Usenet and BitTorrent users                                                                                             | [linuxserver/radarr](https://hub.docker.com/r/linuxserver/radarr)                        | /radarr       |
| [Prowlarr](https://github.com/Prowlarr/Prowlarr)                   | Indexer aggregator for Sonarr and Radarr                                                                                                             | [linuxserver/prowlarr:latest](https://hub.docker.com/r/linuxserver/prowlarr)             | /prowlarr     |
| [Bazarr](https://www.bazarr.media/)                                | Companion application to Sonarr and Radarr that manages and downloads subtitles                                                                      | [linuxserver/bazarr](https://hub.docker.com/r/linuxserver/bazarr)                        | /bazarr       |
| [Jackett](https://github.com/Jackett/Jackett)                      | Ummmmmmmm                                                                                                                                            | [linuxserver/jackett:latest](https://hub.docker.com/r/linuxserver/jackett)               | /jackett      |
| [GlueTun](https://github.com/qdm12/gluetun)                        | VPN thingy for qbittorent                                                                                                                            | [thrnz/docker-wireguard-pia](https://hub.docker.com/r/thrnz/docker-wireguard-pia)        | /gluetun      |
| [qBittorrent](https://www.qbittorrent.org)                         | Bittorrent client with a complete web UI<br/>Uses VPN network<br/>Using Libtorrent 1.x                                                               | [linuxserver/qbittorrent:libtorrentv1](https://hub.docker.com/r/linuxserver/qbittorrent) | /qbittorrent  |
| [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr)       | Optional - Proxy server to bypass Cloudflare protection in Prowlarr<br/>Enable with `COMPOSE_PROFILES=flaresolverr`                                  | [flaresolverr/flaresolverr](https://hub.docker.com/r/flaresolverr/flaresolverr)          | /flaresolverr |
<!-- | [PIA WireGuard VPN](https://github.com/thrnz/docker-wireguard-pia) | Encapsulate qBittorrent traffic in [PIA](https://www.privateinternetaccess.com/) using [WireGuard](https://www.wireguard.com/) with port forwarding. | [thrnz/docker-wireguard-pia](https://hub.docker.com/r/thrnz/docker-wireguard-pia)        |              | -->
<!-- | [Unpackerr](https://unpackerr.zip)                                 | Automated Archive Extractions                                                                                                                        | [golift/unpackerr](https://hub.docker.com/r/golift/unpackerr)                            |              | -->
<!-- | [Traefik](https://traefik.io)                                      | Reverse proxy                                                                                                                                        | [traefik](https://hub.docker.com/_/traefik)                                              |              | -->
<!-- | [Watchtower](https://containrrr.dev/watchtower/)                   | Automated Docker images update                                                                                                                       | [containrrr/watchtower](https://hub.docker.com/r/containrrr/watchtower)                  |              | -->
<!-- | [Autoheal](https://github.com/willfarrell/docker-autoheal/)        | Monitor and restart unhealthy Docker containers                                                                                                      | [willfarrell/autoheal](https://hub.docker.com/r/willfarrell/autoheal)                    |              | -->
<!-- | [Lidarr](https://lidarr.audio)                                     | Optional - Music collection manager for Usenet and BitTorrent users<br/>Enable with `COMPOSE_PROFILES=lidarr`                                        | [linuxserver/lidarr](https://hub.docker.com/r/linuxserver/lidarr)                        | /lidarr      | -->
<!-- | [AdGuard Home](https://adguard.com/en/adguard-home/overview.html)  | Optional - Network-wide software for blocking ads & tracking<br/>Enable with `COMPOSE_PROFILES=adguardhome`                                          | [adguard/adguardhome](https://hub.docker.com/r/adguard/adguardhome)                      |              | -->

```sh
./gen_env.sh
```

download [magic ProtonVPN stuff](https://github.com/Morzomb/All-jellyfin-media-server/tree/Main?tab=readme-ov-file#proton) and edit the .env file

after you changed the .env file, run:

```sh
./setup.sh
./start.sh
```

now go configure stuff from the web interfaces
* Jellyfin : http://localhost:8096
* Jellyseerr : http://localhost:5055
* Sonarr : http://localhost:8989
* Radarr : http://localhost:7878
* Prowlarr : http://localhost:9696
* Jackett : http://localhost:9117
* qBittorrent : http://localhost:9124

firstly, go to your terminal
```sh
sudo docker logs -f qbittorrent
```

search for something like that:
```
The WebUI administrator password was not set. A temporary password is provided for this session: <verysecretpassword>
```

if you don't see it, the password might be `adminadmin` (very secure)

now go to the WebUI: http://localhost:9124 and log in:
* username: admin
* password: <verysecretpassword>

you can change your password in the settings

now start following the tutorial thingy on [Morzomb/All-jellyfin-media-server](https://github.com/Morzomb/All-jellyfin-media-server/tree/Main?tab=readme-ov-file#configuration-guide-for-web-interfaces-only)

notes for myself cuz im dumb:
- on the host thingy on radarr and sonarr on qbittorrent download clients, the host is the local ip `192.168.x.y` and not `qbittorrent`
- on Prowlarr, add the flaresolverr tag to your indexer cuz u dumb


---

# **Disclaimer**
This code is provided for educational purposes only and should not be used for illegal activities. I am not responsible for the actions performed by users of this code. This code is for educational purposes, and if people wish to use it, they should consult the laws of their countries.
