#!/bin/sh
set -eu

mkdir -p /data/media/tv /data/media/movies /data/torrents/tv /data/torrents/movies /arr /arr/prowlarr /arr/radarr /arr/sonarr /arr/qbittorrent /arr/qbittorrent/config /arr/filebrowserquantum/data /arr/jellyfin/config/root/default/Movies /arr/jellyfin/config/root/default/Shows /arr/jellyfin/config/config

chown -R 1000:1000 /data/media/tv /data/media/movies /data/torrents/tv /data/torrents/movies /arr /arr/prowlarr /arr/radarr /arr/sonarr /arr/qbittorrent /arr/qbittorrent/config /arr/filebrowserquantum/data /arr/jellyfin/config/root/default/Movies /arr/jellyfin/config/root/default/Shows /arr/jellyfin/config/config

chmod -R a=,a+rX,u+w,g+w /data/media/tv /data/media/movies /data/torrents/tv /data/torrents/movies /arr /arr/prowlarr /arr/radarr /arr/sonarr /arr/qbittorrent /arr/qbittorrent/config /arr/filebrowserquantum/data /arr/jellyfin/config/root/default/Movies /arr/jellyfin/config/root/default/Shows /arr/jellyfin/config/config

##################################
# ---.env---
##################################
cd /arr
cat > .env <<EOF
HOST_IP=192.168.1.9
EOF
source .env
export HOST_IP=192.168.1.9
##################################
# ---Jellyfin-Movies-location---
##################################
cd /arr/jellyfin/config/root/default/Movies
cat > options.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<LibraryOptions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Enabled>true</Enabled>
  <EnablePhotos>true</EnablePhotos>
  <EnableRealtimeMonitor>true</EnableRealtimeMonitor>
  <EnableLUFSScan>true</EnableLUFSScan>
  <EnableChapterImageExtraction>false</EnableChapterImageExtraction>
  <ExtractChapterImagesDuringLibraryScan>false</ExtractChapterImagesDuringLibraryScan>
  <EnableTrickplayImageExtraction>false</EnableTrickplayImageExtraction>
  <ExtractTrickplayImagesDuringLibraryScan>false</ExtractTrickplayImagesDuringLibraryScan>
  <PathInfos>
    <MediaPathInfo>
      <Path>/data/media/movies</Path>
    </MediaPathInfo>
  </PathInfos>
  <SaveLocalMetadata>false</SaveLocalMetadata>
  <EnableAutomaticSeriesGrouping>false</EnableAutomaticSeriesGrouping>
  <EnableEmbeddedTitles>false</EnableEmbeddedTitles>
  <EnableEmbeddedExtrasTitles>false</EnableEmbeddedExtrasTitles>
  <EnableEmbeddedEpisodeInfos>false</EnableEmbeddedEpisodeInfos>
  <AutomaticRefreshIntervalDays>0</AutomaticRefreshIntervalDays>
  <PreferredMetadataLanguage>en</PreferredMetadataLanguage>
  <MetadataCountryCode>SE</MetadataCountryCode>
  <SeasonZeroDisplayName>Specials</SeasonZeroDisplayName>
  <MetadataSavers />
  <DisabledLocalMetadataReaders />
  <LocalMetadataReaderOrder>
    <string>Nfo</string>
  </LocalMetadataReaderOrder>
  <DisabledSubtitleFetchers />
  <SubtitleFetcherOrder />
  <DisabledMediaSegmentProviders />
  <MediaSegmentProviderOrder />
  <SkipSubtitlesIfEmbeddedSubtitlesPresent>false</SkipSubtitlesIfEmbeddedSubtitlesPresent>
  <SkipSubtitlesIfAudioTrackMatches>false</SkipSubtitlesIfAudioTrackMatches>
  <SubtitleDownloadLanguages />
  <RequirePerfectSubtitleMatch>true</RequirePerfectSubtitleMatch>
  <SaveSubtitlesWithMedia>true</SaveSubtitlesWithMedia>
  <DisabledLyricFetchers />
  <LyricFetcherOrder />
  <CustomTagDelimiters>
    <string>/</string>
    <string>|</string>
    <string>;</string>
    <string>\</string>
  </CustomTagDelimiters>
  <DelimiterWhitelist />
  <AutomaticallyAddToCollection>false</AutomaticallyAddToCollection>
  <AllowEmbeddedSubtitles>AllowAll</AllowEmbeddedSubtitles>
  <TypeOptions>
    <TypeOptions>
      <Type>Movie</Type>
      <MetadataFetchers>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
      </MetadataFetchers>
      <MetadataFetcherOrder>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
      </MetadataFetcherOrder>
      <ImageFetchers>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
        <string>Embedded Image Extractor</string>
        <string>Screen Grabber</string>
      </ImageFetchers>
      <ImageFetcherOrder>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
        <string>Embedded Image Extractor</string>
        <string>Screen Grabber</string>
      </ImageFetcherOrder>
      <ImageOptions />
    </TypeOptions>
  </TypeOptions>
</LibraryOptions>
EOF

##################################
# ---Jellyfin-Shows-location---
##################################
cd /arr/jellyfin/config/root/default/Shows
cat > options.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<LibraryOptions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Enabled>true</Enabled>
  <EnablePhotos>true</EnablePhotos>
  <EnableRealtimeMonitor>true</EnableRealtimeMonitor>
  <EnableLUFSScan>true</EnableLUFSScan>
  <EnableChapterImageExtraction>false</EnableChapterImageExtraction>
  <ExtractChapterImagesDuringLibraryScan>false</ExtractChapterImagesDuringLibraryScan>
  <EnableTrickplayImageExtraction>false</EnableTrickplayImageExtraction>
  <ExtractTrickplayImagesDuringLibraryScan>false</ExtractTrickplayImagesDuringLibraryScan>
  <PathInfos>
    <MediaPathInfo>
      <Path>/data/media/tv</Path>
    </MediaPathInfo>
  </PathInfos>
  <SaveLocalMetadata>false</SaveLocalMetadata>
  <EnableAutomaticSeriesGrouping>false</EnableAutomaticSeriesGrouping>
  <EnableEmbeddedTitles>false</EnableEmbeddedTitles>
  <EnableEmbeddedExtrasTitles>false</EnableEmbeddedExtrasTitles>
  <EnableEmbeddedEpisodeInfos>false</EnableEmbeddedEpisodeInfos>
  <AutomaticRefreshIntervalDays>0</AutomaticRefreshIntervalDays>
  <PreferredMetadataLanguage>en</PreferredMetadataLanguage>
  <MetadataCountryCode>SE</MetadataCountryCode>
  <SeasonZeroDisplayName>Specials</SeasonZeroDisplayName>
  <MetadataSavers />
  <DisabledLocalMetadataReaders />
  <LocalMetadataReaderOrder>
    <string>Nfo</string>
  </LocalMetadataReaderOrder>
  <DisabledSubtitleFetchers />
  <SubtitleFetcherOrder />
  <DisabledMediaSegmentProviders />
  <MediaSegmentProviderOrder />
  <SkipSubtitlesIfEmbeddedSubtitlesPresent>false</SkipSubtitlesIfEmbeddedSubtitlesPresent>
  <SkipSubtitlesIfAudioTrackMatches>false</SkipSubtitlesIfAudioTrackMatches>
  <SubtitleDownloadLanguages />
  <RequirePerfectSubtitleMatch>true</RequirePerfectSubtitleMatch>
  <SaveSubtitlesWithMedia>true</SaveSubtitlesWithMedia>
  <DisabledLyricFetchers />
  <LyricFetcherOrder />
  <CustomTagDelimiters>
    <string>/</string>
    <string>|</string>
    <string>;</string>
    <string>\</string>
  </CustomTagDelimiters>
  <DelimiterWhitelist />
  <AutomaticallyAddToCollection>false</AutomaticallyAddToCollection>
  <AllowEmbeddedSubtitles>AllowAll</AllowEmbeddedSubtitles>
  <TypeOptions>
    <TypeOptions>
      <Type>Series</Type>
      <MetadataFetchers>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
      </MetadataFetchers>
      <MetadataFetcherOrder>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
      </MetadataFetcherOrder>
      <ImageFetchers>
        <string>TheMovieDb</string>
      </ImageFetchers>
      <ImageFetcherOrder>
        <string>TheMovieDb</string>
      </ImageFetcherOrder>
      <ImageOptions />
    </TypeOptions>
    <TypeOptions>
      <Type>Season</Type>
      <MetadataFetchers>
        <string>TheMovieDb</string>
      </MetadataFetchers>
      <MetadataFetcherOrder>
        <string>TheMovieDb</string>
      </MetadataFetcherOrder>
      <ImageFetchers>
        <string>TheMovieDb</string>
      </ImageFetchers>
      <ImageFetcherOrder>
        <string>TheMovieDb</string>
      </ImageFetcherOrder>
      <ImageOptions />
    </TypeOptions>
    <TypeOptions>
      <Type>Episode</Type>
      <MetadataFetchers>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
      </MetadataFetchers>
      <MetadataFetcherOrder>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
      </MetadataFetcherOrder>
      <ImageFetchers>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
        <string>Embedded Image Extractor</string>
        <string>Screen Grabber</string>
      </ImageFetchers>
      <ImageFetcherOrder>
        <string>TheMovieDb</string>
        <string>The Open Movie Database</string>
        <string>Embedded Image Extractor</string>
        <string>Screen Grabber</string>
      </ImageFetcherOrder>
      <ImageOptions />
    </TypeOptions>
  </TypeOptions>
</LibraryOptions>
EOF

##################################
# ---Jellyfin-Initial-wizard-location---
##################################
cd /arr/jellyfin/config/config
cat > system.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<ServerConfiguration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <LogFileRetentionDays>3</LogFileRetentionDays>
  <IsStartupWizardCompleted>true</IsStartupWizardCompleted>
  <EnableMetrics>false</EnableMetrics>
  <EnableNormalizedItemByNameIds>true</EnableNormalizedItemByNameIds>
  <IsPortAuthorized>true</IsPortAuthorized>
  <QuickConnectAvailable>true</QuickConnectAvailable>
  <EnableCaseSensitiveItemIds>true</EnableCaseSensitiveItemIds>
  <DisableLiveTvChannelUserDataName>true</DisableLiveTvChannelUserDataName>
  <MetadataPath />
  <PreferredMetadataLanguage>en</PreferredMetadataLanguage>
  <MetadataCountryCode>SE</MetadataCountryCode>
  <SortReplaceCharacters>
    <string>.</string>
    <string>+</string>
    <string>%</string>
  </SortReplaceCharacters>
  <SortRemoveCharacters>
    <string>,</string>
    <string>&amp;</string>
    <string>-</string>
    <string>{</string>
    <string>}</string>
    <string>'</string>
  </SortRemoveCharacters>
  <SortRemoveWords>
    <string>the</string>
    <string>a</string>
    <string>an</string>
  </SortRemoveWords>
  <MinResumePct>5</MinResumePct>
  <MaxResumePct>90</MaxResumePct>
  <MinResumeDurationSeconds>300</MinResumeDurationSeconds>
  <MinAudiobookResume>5</MinAudiobookResume>
  <MaxAudiobookResume>5</MaxAudiobookResume>
  <InactiveSessionThreshold>0</InactiveSessionThreshold>
  <LibraryMonitorDelay>60</LibraryMonitorDelay>
  <LibraryUpdateDuration>30</LibraryUpdateDuration>
  <CacheSize>100</CacheSize>
  <ImageSavingConvention>Legacy</ImageSavingConvention>
  <MetadataOptions>
    <MetadataOptions>
      <ItemType>Book</ItemType>
      <DisabledMetadataSavers />
      <LocalMetadataReaderOrder />
      <DisabledMetadataFetchers />
      <MetadataFetcherOrder />
      <DisabledImageFetchers />
      <ImageFetcherOrder />
    </MetadataOptions>
    <MetadataOptions>
      <ItemType>Movie</ItemType>
      <DisabledMetadataSavers />
      <LocalMetadataReaderOrder />
      <DisabledMetadataFetchers />
      <MetadataFetcherOrder />
      <DisabledImageFetchers />
      <ImageFetcherOrder />
    </MetadataOptions>
    <MetadataOptions>
      <ItemType>MusicVideo</ItemType>
      <DisabledMetadataSavers />
      <LocalMetadataReaderOrder />
      <DisabledMetadataFetchers>
        <string>The Open Movie Database</string>
      </DisabledMetadataFetchers>
      <MetadataFetcherOrder />
      <DisabledImageFetchers>
        <string>The Open Movie Database</string>
      </DisabledImageFetchers>
      <ImageFetcherOrder />
    </MetadataOptions>
    <MetadataOptions>
      <ItemType>Series</ItemType>
      <DisabledMetadataSavers />
      <LocalMetadataReaderOrder />
      <DisabledMetadataFetchers />
      <MetadataFetcherOrder />
      <DisabledImageFetchers />
      <ImageFetcherOrder />
    </MetadataOptions>
    <MetadataOptions>
      <ItemType>MusicAlbum</ItemType>
      <DisabledMetadataSavers />
      <LocalMetadataReaderOrder />
      <DisabledMetadataFetchers>
        <string>TheAudioDB</string>
      </DisabledMetadataFetchers>
      <MetadataFetcherOrder />
      <DisabledImageFetchers />
      <ImageFetcherOrder />
    </MetadataOptions>
    <MetadataOptions>
      <ItemType>MusicArtist</ItemType>
      <DisabledMetadataSavers />
      <LocalMetadataReaderOrder />
      <DisabledMetadataFetchers>
        <string>TheAudioDB</string>
      </DisabledMetadataFetchers>
      <MetadataFetcherOrder />
      <DisabledImageFetchers />
      <ImageFetcherOrder />
    </MetadataOptions>
    <MetadataOptions>
      <ItemType>BoxSet</ItemType>
      <DisabledMetadataSavers />
      <LocalMetadataReaderOrder />
      <DisabledMetadataFetchers />
      <MetadataFetcherOrder />
      <DisabledImageFetchers />
      <ImageFetcherOrder />
    </MetadataOptions>
    <MetadataOptions>
      <ItemType>Season</ItemType>
      <DisabledMetadataSavers />
      <LocalMetadataReaderOrder />
      <DisabledMetadataFetchers />
      <MetadataFetcherOrder />
      <DisabledImageFetchers />
      <ImageFetcherOrder />
    </MetadataOptions>
    <MetadataOptions>
      <ItemType>Episode</ItemType>
      <DisabledMetadataSavers />
      <LocalMetadataReaderOrder />
      <DisabledMetadataFetchers />
      <MetadataFetcherOrder />
      <DisabledImageFetchers />
      <ImageFetcherOrder />
    </MetadataOptions>
  </MetadataOptions>
  <SkipDeserializationForBasicTypes>true</SkipDeserializationForBasicTypes>
  <ServerName>85497bd2ff60</ServerName>
  <UICulture>en-US</UICulture>
  <SaveMetadataHidden>false</SaveMetadataHidden>
  <ContentTypes />
  <RemoteClientBitrateLimit>0</RemoteClientBitrateLimit>
  <EnableFolderView>false</EnableFolderView>
  <EnableGroupingMoviesIntoCollections>false</EnableGroupingMoviesIntoCollections>
  <EnableGroupingShowsIntoCollections>false</EnableGroupingShowsIntoCollections>
  <DisplaySpecialsWithinSeasons>true</DisplaySpecialsWithinSeasons>
  <CodecsUsed />
  <PluginRepositories>
    <RepositoryInfo>
      <Name>Jellyfin Stable</Name>
      <Url>https://repo.jellyfin.org/files/plugin/manifest.json</Url>
      <Enabled>true</Enabled>
    </RepositoryInfo>
  </PluginRepositories>
  <EnableExternalContentInSuggestions>true</EnableExternalContentInSuggestions>
  <ImageExtractionTimeoutMs>0</ImageExtractionTimeoutMs>
  <PathSubstitutions />
  <EnableSlowResponseWarning>true</EnableSlowResponseWarning>
  <SlowResponseThresholdMs>500</SlowResponseThresholdMs>
  <CorsHosts>
    <string>*</string>
  </CorsHosts>
  <ActivityLogRetentionDays>30</ActivityLogRetentionDays>
  <LibraryScanFanoutConcurrency>0</LibraryScanFanoutConcurrency>
  <LibraryMetadataRefreshConcurrency>0</LibraryMetadataRefreshConcurrency>
  <AllowClientLogUpload>true</AllowClientLogUpload>
  <DummyChapterDuration>0</DummyChapterDuration>
  <ChapterImageResolution>MatchSource</ChapterImageResolution>
  <ParallelImageEncodingLimit>0</ParallelImageEncodingLimit>
  <CastReceiverApplications>
    <CastReceiverApplication>
      <Id>F007D354</Id>
      <Name>Stable</Name>
    </CastReceiverApplication>
    <CastReceiverApplication>
      <Id>6F511C87</Id>
      <Name>Unstable</Name>
    </CastReceiverApplication>
  </CastReceiverApplications>
  <TrickplayOptions>
    <EnableHwAcceleration>false</EnableHwAcceleration>
    <EnableHwEncoding>false</EnableHwEncoding>
    <EnableKeyFrameOnlyExtraction>false</EnableKeyFrameOnlyExtraction>
    <ScanBehavior>NonBlocking</ScanBehavior>
    <ProcessPriority>BelowNormal</ProcessPriority>
    <Interval>10000</Interval>
    <WidthResolutions>
      <int>320</int>
    </WidthResolutions>
    <TileWidth>10</TileWidth>
    <TileHeight>10</TileHeight>
    <Qscale>4</Qscale>
    <JpegQuality>90</JpegQuality>
    <ProcessThreads>1</ProcessThreads>
  </TrickplayOptions>
  <EnableLegacyAuthorization>true</EnableLegacyAuthorization>
</ServerConfiguration>
EOF

##################################
# ---config-filebrowser-quantum---
##################################
cd /arr/filebrowserquantum/data
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
# ---config-torrent---
##################################
cd /arr/qbittorrent/config
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
Session\MaxConnections=500
Session\MaxConnectionsPerTorrent=250
Session\MaxUploads=20
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
WebUI\AuthSubnetWhitelist=192.168.1.0/28
WebUI\AuthSubnetWhitelistEnabled=true
WebUI\HostHeaderValidation=false
WebUI\LocalHostAuth=false
WebUI\Port=4444
WebUI\ServerDomains=*

[RSS]
AutoDownloader\DownloadRepacks=true
AutoDownloader\SmartEpisodeFilter=s(\\d+)e(\\d+), (\\d+)x(\\d+), "(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})", "(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})"
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
      - homepage.name=qBittorrent
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
      - ./filebrowserquantum/data:/home/filebrowserquantum/data
    labels:
      - homepage.group=System
      - homepage.name=File Browser
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
sleep 8
docker logs qbittorrent
