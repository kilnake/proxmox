#!/bin/sh

# Create directories and set permissions
mkdir -p /data/media/tv /data/media/music /data/media/movies /data/torrents/tv /data/torrents/music /data/torrents/movies /arr /arr/homepage /arr/prowlarr /arr/radarr /arr/sonarr
chown -R $USER:$USER /data /arr
chmod -R 777 /data /arr

# Download configuration files
cd /arr/homepage
wget -q -O services.yaml https://raw.githubusercontent.com/kilnake/proxmox/main/arr/homepage/services.yaml
wget -q -O bookmarks.yaml https://raw.githubusercontent.com/kilnake/proxmox/main/arr/homepage/bookmarks.yaml
wget -q -O widgets.yaml https://raw.githubusercontent.com/kilnake/proxmox/main/arr/homepage/widgets.yaml
cd /arr/prowlarr
wget -q -O config.xml https://raw.githubusercontent.com/kilnake/proxmox/main/arr/prowlarr/config.xml
cd /arr/radarr
wget -q -O config.xml https://raw.githubusercontent.com/kilnake/proxmox/main/arr/radarr/config.xml
cd /arr/sonarr
wget -q -O config.xml https://raw.githubusercontent.com/kilnake/proxmox/main/arr/sonarr/config.xml
cd /arr
wget -q -O docker-compose.yml https://raw.githubusercontent.com/kilnake/proxmox/main/docker-compose.yml

# Start Docker containers
docker compose up -d

# Display IPv4 address
ip -4 address show dev eth0

# Introduce a delay of 10 seconds
sleep 10

# Display qbittorrent temporary password
docker logs qbittorrent
