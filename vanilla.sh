#!/bin/sh
set -e

mkdir -p /data/media/tv /data/media/movies /data/torrents/tv /data/torrents/movies /arr/prowlarr /arr/radarr /arr/sonarr /arr/filebrowser/data /arr/homepage
chown -R 1000:1000 /data/media/tv /data/media/movies /data/torrents/tv /data/torrents/movies /arr/prowlarr /arr/radarr /arr/sonarr /arr/filebrowser/data /arr/homepage
chmod -R a=,a+rX,u+w,g+w /data/media/tv /data/media/movies /data/torrents/tv /data/torrents/movies /arr/prowlarr /arr/radarr /arr/sonarr /arr/filebrowser/data /arr/homepage

##################################
# ---.env---
##################################
cd /arr
cat > .env <<EOF
HOST_IP=192.168.1.9
EOF
source .env

##################################
# ---config-homepage
##################################
cd /arr/homepage
cat > docker.yaml <<EOF
---
 my-docker:
   socket: /var/run/docker.sock
EOF
cat > settings.yaml <<EOF
---
providers:
  docker:
    socket: /var/run/docker.sock
    
layout:
  System:
    style: row
    columns: 2

  Media:
    style: row
    columns: 2
EOF
cat > services.yaml <<EOF
---
EOF

cat > proxmox.yaml <<EOF
---
EOF

##################################
# ---config-filebrowser-quantum---
##################################
cd /arr/filebrowser/data
cat > config.yaml <<EOF
server:
  sources:
    - path: /folder
      config:
        defaultEnabled: true
auth:
  methods:
    noauth: true

userDefaults:
  editorQuickSave: true
  hideSidebarFileActions: true
  disableQuickToggles: true
  stickySidebar: true
  showHidden: true
  quickDownload: true

  disablePreviewExt: ""                   # space separated list of file extensions to disable preview for
  disableViewingExt: ""                   # space separated list of file extensions to disable viewing for

  preview:
    disableHideSidebar: true
    highQuality: false
    image: false
    video: false
    motionVideoPreview: false
    office: false
    autoplayMedia: false
    defaultMediaPlayer: false
    folder: false
  showSelectMultiple: false
EOF

##################################
# ---config-prowlarr
##################################
cd /arr/prowlarr
cat > config.xml <<EOF
<Config>
  <BindAddress>*</BindAddress>
  <Port>9696</Port>
  <SslPort>6969</SslPort>
  <EnableSsl>False</EnableSsl>
  <ApiKey>*</ApiKey>
  <AuthenticationMethod>External</AuthenticationMethod>
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

##################################
# ---config-radarr
##################################
cd /arr/radarr
cat > config.xml <<EOF
<Config>
  <BindAddress>*</BindAddress>
  <Port>7878</Port>
  <SslPort>9898</SslPort>
  <EnableSsl>False</EnableSsl>
  <ApiKey>*</ApiKey>
  <AuthenticationMethod>External</AuthenticationMethod>
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

##################################
# ---config-sonarr
##################################
cd /arr/sonarr
cat > config.xml <<EOF
<Config>
  <BindAddress>*</BindAddress>
  <Port>8989</Port>
  <SslPort>9898</SslPort>
  <EnableSsl>False</EnableSsl>
  <ApiKey>*</ApiKey>
  <AuthenticationMethod>External</AuthenticationMethod>
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
###############################################
# Common Keys for all apps
###############################################

x-common-keys: &common-keys
    restart: unless-stopped
    environment:
      PUID: 1000
      PGID: 1000
      TZ: Europe/Stockholm


services:
###############################################
# Jellyseerr
###############################################
  jellyseerr:
    <<: *common-keys
    container_name: jellyseerr
    image: ghcr.io/fallenbagel/jellyseerr:latest
    ports:
      - 5055:5055
    volumes:
      - ./jellyseerr:/app/config
    labels:
      - homepage.group=Media
      - homepage.name=Jellyseerr
      - homepage.icon=jellyseerr
      - homepage.href=http://${HOST_IP}:5055
      - homepage.container=jellyseerr

###############################################
# Sonarr
###############################################
  sonarr:
    <<: *common-keys
    container_name: sonarr
    image: ghcr.io/hotio/sonarr:latest
    ports:
      - 8989:8989
    volumes:
      - ./sonarr:/config
      - /data:/data
    labels:
      - homepage.group=Media
      - homepage.name=Sonarr
      - homepage.icon=sonarr
      - homepage.href=http://${HOST_IP}:8989
      - homepage.container=sonarr

###############################################
# Radarr
###############################################
  radarr:
    <<: *common-keys
    container_name: radarr
    image: ghcr.io/hotio/radarr:latest
    ports:
      - 7878:7878
    volumes:
      - ./radarr:/config
      - /data:/data
    labels:
      - homepage.group=Media
      - homepage.name=Radarr
      - homepage.icon=radarr
      - homepage.href=http://${HOST_IP}:7878
      - homepage.container=radarr

###############################################
# Prowlarr
###############################################
  prowlarr:
    <<: *common-keys
    container_name: prowlarr
    image: ghcr.io/hotio/prowlarr:latest
    ports:
      - 9696:9696
    volumes:
      - ./prowlarr:/config
    labels:
      - homepage.group=Media
      - homepage.name=Prowlarr
      - homepage.icon=prowlarr
      - homepage.href=http://${HOST_IP}:9696
      - homepage.container=prowlarr

###############################################
# Flaresolverr
###############################################
  flaresolverr:
    <<: *common-keys
    container_name: flaresolverr
    image: ghcr.io/flaresolverr/flaresolverr:latest
    ports:
      - 8191:8191
    environment:
      - LOG_LEVEL=info
    labels:
      - homepage.group=Media
      - homepage.name=FlareSolverr
      - homepage.icon=cloudflare
      - homepage.href=http://${HOST_IP}:8191
      - homepage.container=flaresolverr

###############################################
# Qbittorrent
###############################################
  qbittorrent:
    <<: *common-keys
    container_name: qbittorrent
    image: lscr.io/linuxserver/qbittorrent:latest
    ports:
      - 4444:4444
      - 6881:6881
      - 6881:6881/udp
    environment:
      - WEBUI_PORT=4444
      - TORRENTING_PORT=6881
    volumes:
      - ./qbittorrent:/config
      - /data/torrents:/data/torrents:rw
    labels:
      - homepage.group=Media
      - homepage.name=qbittorrent
      - homepage.icon=qbittorrent
      - homepage.href=http://${HOST_IP}:4444
      - homepage.container=qbittorrent

###############################################
# Filebrowser-Quantum
###############################################
  filebrowserquantum:
    <<: *common-keys
    container_name: filebrowserquantum
    image: gtstef/filebrowser:stable-slim
    ports:
      - 8080:80
    environment:
      - FILEBROWSER_CONFIG=data/config.yaml
      - FILEBROWSER_DATABASE=data/database.db
    volumes:
      - /:/folder
      - ./filebrowser/data:/home/filebrowser/data
    labels:
      - homepage.group=System
      - homepage.name=Filebrowser Quantum
      - homepage.icon=filebrowser-quantum
      - homepage.href=http://${HOST_IP}:8080
      - homepage.container=filebrowserquantum

###############################################
# Jellyfin
###############################################
  jellyfin:
    <<: *common-keys
    container_name: jellyfin
    image: ghcr.io/jellyfin/jellyfin:latest
    ports:
      - 8096:8096
    volumes:
      - ./jellyfin/config:/config
      - ./jellyfin/cache:/cache
      - /data/media/movies:/data/media/movies
      - /data/media/tv:/data/media/tv
    labels:
      - homepage.group=Media
      - homepage.name=Jellyfin
      - homepage.icon=jellyfin
      - homepage.href=http://${HOST_IP}:8096
      - homepage.container=jellyfin

###############################################
# Watcharr
###############################################
  watcharr:
    <<: *common-keys
    container_name: watcharr
    image: ghcr.io/sbondco/watcharr:latest
    ports:
      - 3080:3080
    volumes:
      - ./watcharr:/data
    labels:
      - homepage.group=Media
      - homepage.name=Watcharr
      - homepage.icon=watcharr
      - homepage.href=http://${HOST_IP}:3080
      - homepage.container=watcharr

###############################################
# Dockhand
###############################################
  dockhand:
    <<: *common-keys
    image: fnsys/dockhand:latest
    container_name: dockhand
    ports:
      - 3000:3000
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./dockhand:/app/data
    labels:
      - homepage.group=System
      - homepage.name=Dockhand
      - homepage.icon=docker
      - homepage.href=http://${HOST_IP}:3000
      - homepage.container=dockhand

###############################################
# Homepage
###############################################
  homepage:
    container_name: homepage
    image: ghcr.io/gethomepage/homepage:latest
    restart: unless-stopped
    ports:
      - 80:3000
    environment:
      - PUID=1000
      - PGID=101
      - TZ=Europe/Stockholm
      - HOMEPAGE_ALLOWED_HOSTS=*
    volumes:
      - ./homepage:/app/config
      - /var/run/docker.sock:/var/run/docker.sock
EOF
docker compose up -d

ip -4 addr show dev eth0
sleep 7
docker logs qbittorrent
