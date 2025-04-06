#!/bin/bash

# STEP 1: Pull and run the container creation script, then wait for manual exit
echo "Running Alpine Docker CT creation script..."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/alpine-docker.sh)"

echo "Please complete the setup in the interactive script. Press ENTER to continue when done."
read

# STEP 2: Wait for 5 seconds
sleep 5

# STEP 3: Find the most recently created container (assuming it's the last created one)
CTID=$(pct list | tail -n 1 | awk '{print $1}')
echo "Detected latest CT ID: $CTID"

# Get container IP address
CT_IP=$(pct exec $CTID ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
echo "Current container IP: $CT_IP"

# Extract subnet from current IP for substitution
SUBNET=$(echo $CT_IP | awk -F. '{print $1 "." $2 "." $3}')
NEW_IP="${SUBNET}.33"
GATEWAY="${SUBNET}.1"

# Stop the container to reconfigure networking
pct stop $CTID

# STEP 3 continued: Set static IP and gateway
pct set $CTID -net0 name=eth0,bridge=vmbr0,ip=${NEW_IP}/24,gw=${GATEWAY}
echo "Set new IP: $NEW_IP/24 with gateway $GATEWAY"

# Start container again
pct start $CTID

# STEP 4: Update container description with the URL
pct set $CTID --description "http://${NEW_IP}:8080"
echo "Updated container description to http://${NEW_IP}:8080"

# STEP 5: Enter the container
echo "Entering container $CTID..."
pct enter $CTID -- bash -c "wget -qO - https://raw.githubusercontent.com/kilnake/proxmox/main/test.sh | bash"
