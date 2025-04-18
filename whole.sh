#!/bin/bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/alpine-docker.sh)"

sleep 5

CT_ID=$(pct list | tail -n +2 | awk '{print $1}' | sort -n | tail -1)
if [[ -z "$CT_ID" ]]; then
    echo "Error: No container ID found!"
    exit 1
fi

sed -i '/^#/d' "/etc/pve/lxc/$CT_ID.conf"

DESCRIPTION="http://192.168.1.33:8989 | http://192.168.1.33:7878 | http://192.168.1.33:9696 | http://192.168.1.33:8191 | http://192.168.1.33:8096 | http://192.168.1.33:8998 | http://192.168.1.33:4444 | http://192.168.1.33:5055 | http://192.168.1.33:3080 | http://192.168.1.33:8080"

echo -e "\n# $DESCRIPTION" >> "/etc/pve/lxc/$CT_ID.conf"

pct enter $(ls -t /etc/pve/lxc/ | head -n1 | sed 's/\.conf//')

pct enter "$CT_ID"

bash -c "$(wget -qO - https://raw.githubusercontent.com/kilnake/proxmox/main/test.sh)"
