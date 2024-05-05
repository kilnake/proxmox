#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/kilnake/proxmox/main/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE 
# Big inspiration for this script

function header_info {
  clear
  cat <<"EOF"


       _       _                      _            _                                   
      | |     (_)                    | |          | |                                  
  __ _| |_ __  _ _ __   ___ ______ __| | ___   ___| | _____ _ __ ______ __ _ _ __ _ __ 
 / _` | | '_ \| | '_ \ / _ \______/ _` |/ _ \ / __| |/ / _ \ '__|______/ _` | '__| '__|
| (_| | | |_) | | | | |  __/     | (_| | (_) | (__|   <  __/ |        | (_| | |  | |   
 \__,_|_| .__/|_|_| |_|\___|      \__,_|\___/ \___|_|\_\___|_|         \__,_|_|  |_|   
        | |                                                                            
        |_|                                                                            


 Alpine
 
EOF
}
header_info
echo -e "Loading..."
APP="arr"
var_disk="200"
var_cpu="3"
var_ram="8096"
var_os="alpine"
var_version="3.19"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
  if ! apk -e info newt >/dev/null 2>&1; then
    apk add -q newt
  fi
  while true; do
    CHOICE=$(
      whiptail --backtitle "Arr" --title "SUPPORT" --menu "Select option" 11 58 1 \
        "1" "Check for Docker Updates" 3>&2 2>&1 1>&3
    )
    exit_status=$?
    if [ $exit_status == 1 ]; then
      clear
      exit-script
    fi
    header_info
    case $CHOICE in
    1)
      apk update && apk upgrade
      exit
      ;;
    esac
  done
}

start
build_container
description

msg_ok "Completed Successfully!\n"