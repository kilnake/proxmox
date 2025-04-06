#!/bin/bash

echo "[1] Launching Alpine Docker CT creation script..."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/alpine-docker.sh)"

read -p "[WAITING] Finish the interactive CT creation and press ENTER to continue..."

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
pct exec $CTID -- /bin/sh -c "apk add --no-cache bash wget && /bin/sh -c "
mkdir -p /data/media/tv /data/media/movies /data/torrents/tv /data/torrents/movies /arr /arr/prowlarr /arr/radarr /arr/sonarr
chown -R $USER:$USER /data /arr /arr/prowlarr /arr/radarr /arr/sonarr
chmod -R 777 /data /arr /arr/prowlarr /arr/radarr /arr/sonarr

cd /arr/prowlarr
cat > config.xml <<EOF
<Config>
  <BindAddress>*</BindAddress>
  <Port>9696</Port>
  <SslPort>6969</SslPort>
  <EnableSsl>False</EnableSsl>
  <LaunchBrowser>True</LaunchBrowser>
  <ApiKey>*</ApiKey>
  <AuthenticationMethod>Basic</AuthenticationMethod>
  <AuthenticationRequired>DisabledForLocalAddresses</AuthenticationRequired>
  <Branch>master</Branch>
  <LogLevel>info</LogLevel>
  <SslCertPath></SslCertPath>
  <SslCertPassword></SslCertPassword>
  <UrlBase></UrlBase>
  <InstanceName>Prowlarr</InstanceName>
  <UpdateMechanism>Docker</UpdateMechanism>
</Config>
EOF

cd /arr/radarr
cat > config.xml <<EOF
<Config>
  <BindAddress>*</BindAddress>
  <Port>7878</Port>
  <SslPort>9898</SslPort>
  <EnableSsl>False</EnableSsl>
  <LaunchBrowser>True</LaunchBrowser>
  <ApiKey>*</ApiKey>
  <AuthenticationMethod>Basic</AuthenticationMethod>
  <AuthenticationRequired>DisabledForLocalAddresses</AuthenticationRequired>
  <Branch>master</Branch>
  <LogLevel>info</LogLevel>
  <SslCertPath></SslCertPath>
  <SslCertPassword></SslCertPassword>
  <UrlBase></UrlBase>
  <InstanceName>Radarr</InstanceName>
  <UpdateMechanism>Docker</UpdateMechanism>
</Config>
EOF

cd /arr/sonarr
cat > config.xml <<EOF
<Config>
  <BindAddress>*</BindAddress>
  <Port>8989</Port>
  <SslPort>9898</SslPort>
  <EnableSsl>False</EnableSsl>
  <LaunchBrowser>True</LaunchBrowser>
  <ApiKey>*</ApiKey>
  <AuthenticationMethod>Basic</AuthenticationMethod>
  <AuthenticationRequired>DisabledForLocalAddresses</AuthenticationRequired>
  <Branch>main</Branch>
  <LogLevel>info</LogLevel>
  <SslCertPath></SslCertPath>
  <SslCertPassword></SslCertPassword>
  <UrlBase></UrlBase>
  <InstanceName>Sonarr</InstanceName>
  <UpdateMechanism>Docker</UpdateMechanism>
</Config>
EOF

cd /arr
cat > docker-compose.yml <<EOF
services:
  sonarr:
    container_name: sonarr
    image: linuxserver/sonarr:latest
    restart: unless-stopped
    ports:
      - 8989:8989
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
    volumes:
      - ./sonarr:/config
      - /data:/data
  radarr:
    container_name: radarr
    image: linuxserver/radarr:latest
    restart: unless-stopped
    ports:
      - 7878:7878
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
    volumes:
      - ./radarr:/config
      - /data:/data
  prowlarr:
    container_name: prowlarr
    image: linuxserver/prowlarr:latest
    restart: unless-stopped
    ports:
      - 9696:9696
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
    volumes:
      - ./prowlarr:/config
  watcharr:
    container_name: watcharr
    image: ghcr.io/sbondco/watcharr:latest
    restart: unless-stopped
    ports:
      - 3080:3080
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
    volumes:
      - ./watcharr:/data
  jellyseerr:
    container_name: jellyseerr
    image: fallenbagel/jellyseerr:latest
    restart: unless-stopped
    ports:
      - 5055:5055
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
    volumes:
      - ./jellyseerr:/app/config
  flaresolverr:
    container_name: flaresolverr
    image: ghcr.io/flaresolverr/flaresolverr:latest
    restart: unless-stopped
    ports:
      - 8191:8191
    environment:
      - LOG_LEVEL=${LOG_LEVEL:-info}
      - LOG_HTML=${LOG_HTML:-false}
      - CAPTCHA_SOLVER=${CAPTCHA_SOLVER:-none}
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
  jellyfin:
    container_name: jellyfin
    image: linuxserver/jellyfin:latest
    restart: unless-stopped
    ports:
      - 8096:8096
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
    volumes:
      - ./jellyfin:/config
      - /data/media:/data/media
  qbittorrent:
    container_name: qbittorrent
    image: linuxserver/qbittorrent:latest
    restart: unless-stopped
    ports:
      - 4444:4444
      - 6881:6881
      - 6881:6881/udp
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
      - WEBUI_PORT=4444
      - TORRENTING_PORT=6881
    volumes:
      - ./qbittorrent:/config
      - /data/torrents:/data/torrents:rw
  ytdl_material:
    container_name: Youtube-download
    image: tzahi12345/youtubedl-material:latest
    restart: unless-stopped
    depends_on:
      - ytdl-mongo-db
    ports:
      - 8998:17442
    environment:
      ytdl_mongodb_connection_string: 'mongodb://ytdl-mongo-db:27017'
      ytdl_use_local_db: 'false'
      write_ytdl_config: 'true'
    volumes:
      - ./ytdl/appdata:/app/appdata
      - /data/media/ytdl/audio:/app/audio
      - /data/media/ytdl/video:/app/video
      - /data/media/ytdl/subscriptions:/app/subscriptions
      - /data/media/ytdl/users:/app/users
  ytdl-mongo-db:
    container_name: mongo-db
    image: mongo:4
    restart: unless-stopped
    logging:
      driver: none
    volumes:
      - ./ytdl/db/:/data/db
  filebrowser:
    container_name: filebrowser
    image: filebrowser/filebrowser:latest
    restart: unless-stopped
    ports:
      - 8080:80
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
      - FB_NOAUTH=true
    volumes:
      - /:/srv
EOF
docker compose up -d

# Display IPv4 address
ip -4 address show dev eth0
# Introduce a delay of 10 seconds
sleep 10

# Display qbittorrent temporary password
docker logs qbittorrent
"


echo "[✔️  DONE] Container $CTID is configured and script is executed."
