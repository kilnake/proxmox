#!/bin/sh
set -euo pipefail
# ----------------------------------------------Making folders and giving permissions
mkdir -p /data/media/tv /data/media/movies /data/torrents/tv /data/torrents/movies /arr /arr/prowlarr /arr/radarr /arr/sonarr /arr/qBittorrent /arr/homepage
chown -R $USER:$USER /data /arr /arr/prowlarr /arr/radarr /arr/sonarr /arr/qBittorrent /arr/homepage
chmod -R 777 /data /arr /arr/prowlarr /arr/radarr /arr/sonarr /arr/qBittorrent /arr/homepage

# ----------------------------------------------config-homepage
cd /arr/homepage
cat > widgets.yaml <<EOF
---
# https://gethomepage.dev/latest/configs/service-widgets

- logo:
    icon: https://raw.githubusercontent.com/kilnake/proxmox/main/arr/homepage/ravi_kilnake_logo.svg

- resources:
    cpu: true
    memory: true
    disk: /

- search:
    provider: brave
    target: _blank

- datetime:
    text_size: xl
    format:
      hourCycle: h23
      timeStyle: short
      dateStyle: long

- openmeteo:
    label: Höganäs # optional
    latitude: 56.19211
    longitude: 12.57455
    timezone: Europe/Stockholm # optional
    units: metric # or imperial
    cache: 5 # Time in minutes to cache API responses, to stay within limits
    format: # optional, Intl.NumberFormat options
      maximumFractionDigits: 1
EOF

cat > bookmarks.yaml <<EOF
---
EOF

cat > settings.yaml <<EOF
---
# https://gethomepage.dev/latest/configs/settings

providers:
  openweathermap: openweathermapapikey
  weatherapi: weatherapiapikey
EOF

cat > services.yaml <<EOF
---
- Management:
    - Filebrowser:
        icon: filebrowser.png
        href: http://192.168.1.4:8080/
    - Docking-Station:
        icon: docking-station.png
        href: http://192.168.1.4:12000

- Ads Management:
    - Pi-hole:
        icon: pi-hole.png
        href: https://192.168.1.2/admin/login

- What is Trending:
    - Jellyseerr:
        icon: jellyseerr.png
        href: http://192.168.1.4:5055/

- What we saw:
    - Watcharr:
        icon: watcharr.png
        href: http://192.168.1.4:3080/

- Downloads:
    - Qbittorrent:
        icon: qbittorrent.png
        href: http://192.168.1.4:4444/
    - YT-DL:
        icon: youtube.png
        href: http://192.168.1.4:8998/

- Indexers:
    - Sonarr:
        icon: sonarr.png
        href: http://192.168.1.4:8989/
        description: Series
    - Radarr:
        icon: radarr.png
        href: http://192.168.1.4:7878/
        description: Movies
    - Bazarr:
        icon: bazarr.png
        href: http://192.168.1.4:6767/
        description: Subtitles

- Resolvers:
    - Flaresolverr:
        icon: flaresolverr.png
        href: http://192.168.1.4:8191/
    - Prowlarr:
        icon: prowlarr.png
        href: http://192.168.1.4:9696/

- Players:
    - Jellyfin:
        icon: jellyfin.png
        href: http://192.168.1.4:8096/
        description: Video Player
EOF

# ----------------------------------------------config-torrent
cd /arr/qBittorrent
cat > categories.json <<EOF
{
    "movies": {
        "save_path": "movies"
    },
    "tv": {
        "save_path": "tv"
    }
}
EOF
cat > qBittorrent.conf <<EOF
[Application]
FileLogger\Age=1
FileLogger\AgeType=1
FileLogger\Backup=true
FileLogger\DeleteOld=true
FileLogger\Enabled=true
FileLogger\MaxSizeBytes=66560
FileLogger\Path=/config/qBittorrent/logs

[AutoRun]
enabled=false
program=

[BitTorrent]
Session\AddTorrentStopped=false
Session\AddTrackersEnabled=true
Session\AdditionalTrackers=http://1337.abcvg.info:80/announce\n\nhttp://bt.okmp3.ru:2710/announce\n\nhttp://ipv6.rer.lol:6969/announce\n\nhttp://nyaa.tracker.wf:7777/announce\n\nhttp://t.nyaatracker.com:80/announce\n\nhttp://tk.greedland.net:80/announce\n\nhttp://torrentsmd.com:8080/announce\n\nhttp://tracker.bt4g.com:2095/announce\n\nhttp://tracker.electro-torrent.pl:80/announce\n\nhttp://tracker.files.fm:6969/announce\n\nhttp://tracker.opentrackr.org:1337/announce\n\nhttp://tracker.tfile.co:80/announce\n\nhttp://www.all4nothin.net:80/announce.php\n\nhttp://www.wareztorrent.com:80/announce\n\nhttps://tr.burnabyhighstar.com:443/announce\n\nhttps://tracker.amelia.fun:443/announce\n\nhttps://tracker.kuroy.me:443/announce\n\nhttps://tracker.lilithraws.org:443/announce\n\nhttps://tracker.loligirl.cn:443/announce\n\nhttps://tracker.tamersunion.org:443/announce\n\nhttps://tracker.yemekyedim.com:443/announce\n\nhttps://tracker1.520.jp:443/announce\n\nhttps://trackers.mlsub.net:443/announce\n\nudp://bt1.archive.org:6969/announce\n\nudp://bt2.archive.org:6969/announce\n\nudp://evan.im:6969/announce\n\nudp://exodus.desync.com:6969/announce\n\nudp://ipv6.fuuuuuck.com:6969/announce\n\nudp://leet-tracker.moe:1337/announce\n\nudp://oh.fuuuuuck.com:6969/announce\n\nudp://open.demonii.com:1337/announce\n\nudp://open.free-tracker.ga:6969/announce\n\nudp://open.stealth.si:80/announce\n\nudp://open.tracker.cl:1337/announce\n\nudp://open.tracker.ink:6969/announce\n\nudp://open.u-p.pw:6969/announce\n\nudp://opentor.org:2710/announce\n\nudp://opentracker.io:6969/announce\n\nudp://p4p.arenabg.com:1337/announce\n\nudp://retracker.lanta.me:2710/announce\n\nudp://retracker01-msk-virt.corbina.net:80/announce\n\nudp://run.publictracker.xyz:6969/announce\n\nudp://thetracker.org:80/announce\n\nudp://tracker.0x7c0.com:6969/announce\n\nudp://tracker.birkenwald.de:6969/announce\n\nudp://tracker.bittor.pw:1337/announce\n\nudp://tracker.cyberia.is:6969/announce\n\nudp://tracker.dler.com:6969/announce\n\nudp://tracker.doko.moe:6969/announce\n\nudp://tracker.fnix.net:6969/announce\n\nudp://tracker.opentrackr.org:1337/announce\n\nudp://tracker.skyts.net:6969/announce\n\nudp://tracker.t-1.org:6969/announce\n\nudp://tracker.xor.st:6969/announce\n\nudp://tracker1.bt.moack.co.kr:80/announce\n\nudp://tracker1.t-1.org:6969/announce\n\nudp://tracker3.t-1.org:6969/announce\n\nwss://tracker.openwebtorrent.com:443/announce
Session\DefaultSavePath=/data/torrents
Session\DisableAutoTMMByDefault=false
Session\DisableAutoTMMTriggers\CategorySavePathChanged=false
Session\DisableAutoTMMTriggers\DefaultSavePathChanged=false
Session\ExcludedFileNames=
Session\IgnoreLimitsOnLAN=true
Session\MaxActiveDownloads=200
Session\MaxActiveTorrents=200
Session\MaxActiveUploads=20
Session\MaxConnections=5000
Session\MaxConnectionsPerTorrent=2500
Session\MaxUploads=200
Session\MaxUploadsPerTorrent=40
Session\Port=6881
Session\Preallocation=true
Session\QueueingSystemEnabled=true
Session\SSL\Port=49924
Session\ShareLimitAction=Stop
Session\TempPath=/downloads/incomplete/
Session\uTPRateLimited=false

[Core]
AutoDeleteAddedTorrentFile=IfAdded

[LegalNotice]
Accepted=true

[Meta]
MigrationVersion=8

[Network]
Cookies=@Invalid()
PortForwardingEnabled=false
Proxy\HostnameLookupEnabled=false
Proxy\Profiles\BitTorrent=true
Proxy\Profiles\Misc=true
Proxy\Profiles\RSS=true

[Preferences]
Connection\PortRangeMin=6881
Connection\UPnP=false
Downloads\SavePath=/downloads/
Downloads\TempPath=/downloads/incomplete/
General\DeleteTorrentsFilesAsDefault=false
General\Locale=en
MailNotification\password=
MailNotification\req_auth=false
MailNotification\username=
WebUI\Address=*
WebUI\AuthSubnetWhitelist=192.168.1.0/24
WebUI\AuthSubnetWhitelistEnabled=true
WebUI\HostHeaderValidation=false
WebUI\LocalHostAuth=false
WebUI\Port=4444
WebUI\ServerDomains=*

[RSS]
AutoDownloader\DownloadRepacks=true
AutoDownloader\SmartEpisodeFilter=s(\\d+)e(\\d+), (\\d+)x(\\d+), "(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})", "(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})"
EOF

# ----------------------------------------------config-prowlarr
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

# ----------------------------------------------config-radarr
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

# ----------------------------------------------config-sonarr
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
    image: lscr.io/linuxserver/prowlarr:latest
    restart: unless-stopped
    ports:
      - 9696:9696
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
    volumes:
      - ./prowlarr:/config
  bazarr:
    container_name: bazarr
    image: lscr.io/linuxserver/bazarr:latest
    restart: unless-stopped
    ports:
      - 6767:6767
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
    volumes:
      - ./bazarr:/config
      - /data/media/movies:/movies
      - /data/media/tv:/tv
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
    image: lscr.io/linuxserver/qbittorrent:latest
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
      - ./:/config
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
  homepage:
    container_name: homepage
    image: ghcr.io/gethomepage/homepage:latest
    restart: unless-stopped
    ports:
      - 80:3000
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Stockholm
      - HOMEPAGE_ALLOWED_HOSTS=*
    volumes:
      - ./homepage:/app/config
      - /var/run/docker.sock:/var/run/docker.sock
  portainer:
    container_name: portainer
    image: portainer/portainer-ce:2.21.5
    restart: unless-stopped
    ports:
      - 9443:9443
    volumes:
      - ./portainer:/data
      - /var/run/docker.sock:/var/run/docker.sock
  docking-station:
    container_name: docking-station
    image: loolzzz/docking-station
    restart: unless-stopped
    ports:
      - 12000:3000
    volumes:
      - ./docking-station:/config
      - ./docking-station/data:/data
      - ./docking-station/logs:/logs
      - /var/run/docker.sock:/var/run/docker.sock
      - /arr:/arr
EOF
docker compose up -d

ip -4 address show dev eth0
sleep 10
docker logs qbittorrent
