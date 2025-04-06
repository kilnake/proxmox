#!/bin/bash

echo "[1] Launching Alpine Docker CT creation script..."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/alpine-docker.sh)"

echo "[2] Sleeping for 5 seconds..."
sleep 5

echo "[3] Finding the most recently created container..."
CTID=$(pct list | awk 'NR>1 {print $1}' | sort -n | tail -1)
echo "[INFO] Found container ID: $CTID"

echo "[3.1] Fetching current container IP..."
CT_IP=$(pct exec $CTID -- ip -4 -o addr show eth0 | awk '{print $4}' | cut -d/ -f1)

if [[ -z "$CT_IP" ]]; then
    echo "[ERROR] Could not retrieve IP address from container $CTID"
    exit 1
fi

SUBNET=$(echo "$CT_IP" | awk -F. '{print $1 "." $2 "." $3}')
NEW_IP="${SUBNET}.33"
GATEWAY="${SUBNET}.1"

echo "[3.2] Setting static IP: $NEW_IP/24 with gateway $GATEWAY"

# Stop container before applying network change
pct stop $CTID

# Set static IP using Proxmox tools
pct set $CTID -net0 name=eth0,bridge=vmbr0,ip=${NEW_IP}/24,gw=${GATEWAY}

# Start container again
pct start $CTID

# STEP 4: Set notes/description with access link
echo "[4] Setting container description in Proxmox..."
pct set $CTID --description "http://${NEW_IP}:8080"

# STEP 5 & 6: Enter container, install bash + wget, then run the remote script
echo "[5] Entering Alpine container and executing script..."
pct exec $CTID -- /bin/sh -c "apk add --no-cache bash wget" && "bash -c "$(wget -qO - https://raw.githubusercontent.com/kilnake/proxmox/main/test.sh)""
