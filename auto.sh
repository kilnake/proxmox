#!/bin/sh

# Configure static IPv4 address
cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.168.1.20
    netmask 255.255.255.0
    gateway 192.168.1.1
EOF

# Configure static IPv6 address and gateway
echo "iface eth0 inet6 static" >> /etc/network/interfaces
echo "    address 2001:9b1:cdc0:a300::20/128" >> /etc/network/interfaces
echo "    gateway 2001:9b1:cdc0:a300::1" >> /etc/network/interfaces

# Restart networking service
service networking restart

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
