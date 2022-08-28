#!/bin/bash

PATH_TO_SCRIPTS = "$HOME/bash-debian-server"
PATH_TO_SERVER_DATA = $HOME/truenas/Config/server_data
PATH_TO_SERVER_MEDIA = $HOME/truenas/truenas/Public/Torrent

PATH_TO_JELLYFIN = $HOME/truenas/jellyfin

#Installing Watchtower
sudo docker run -d \
 --name watchtower \
 -v /var/run/docker.sock:/var/run/docker.sock \
 containrrr/watchtower:latest \
 --run-once \
 --cleanup \
 --include-restarting \
 --include-stopped

#Installing portainer
cd $PATH_TO_SCRIPTS
mkdir $PATH_TO_SERVER_DATA/portainer_data
cd portainer
docker-compose up -d

#Installing jellyfin
cd $PATH_TO_SCRIPTS
mkdir $PATH_TO_SERVER_DATA/jellyfin
mkdir $PATH_TO_SERVER_DATA/jellyfin/jellyfin_cache
mkdir $PATH_TO_SERVER_DATA/jellyfin/jellyfin_config
cd jellyfin
docker-compose up -d