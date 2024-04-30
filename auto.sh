#!/bin/sh

mkdir -p /data/media/tv /data/media/music /data/media/movies /data/torrents/tv /data/torrents/music /data/torrents/movies /arr
chown -R $USER:$USER /data /arr
chmod -R 777 /data /arr
cd /arr
wget -q -O docker-compose.yml https://raw.githubusercontent.com/kilnake/proxmox/main/docker-compose.yml
docker compose up -d
ip -4 address show dev eth0
