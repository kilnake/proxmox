#!/bin/sh

mkdir -p /data/media/tv /data/media/music /data/media/movies /data/torrents/tv /data/torrents/music /data/torrents/movies /arr /arr/homepage /arr/homepage 
chown -R $USER:$USER /data /arr
chmod -R 755 /data /arr
cd /arr/homepage
wget -q -O bookmarks.yaml https://raw.githubusercontent.com/kilnake/proxmox/main/bookmarks.yaml
wget -q -O services.yaml https://raw.githubusercontent.com/kilnake/proxmox/main/services.yaml
wget -q -O settings.yaml https://raw.githubusercontent.com/kilnake/proxmox/main/settings.yaml
wget -q -O widgets.yaml https://raw.githubusercontent.com/kilnake/proxmox/main/widgets.yaml
cd /arr
wget -q -O docker-compose.yml https://raw.githubusercontent.com/kilnake/proxmox/main/docker-compose.yml
docker compose up -d
ip -4 address show dev eth0
