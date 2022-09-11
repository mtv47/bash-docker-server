#!/bin/bash

PATH_TO_SCRIPTS="$HOME/bash-docker-server"
mkdir $HOME/docker_data
DOCKER_DATA="$HOME/docker_data"


echo "================================================================================"
echo "Installing Watchtower"
sudo docker run -d \
 --name watchtower \
 -v /var/run/docker.sock:/var/run/docker.sock \
 containrrr/watchtower:latest \
 --run-once \
 --cleanup \
 --include-restarting \
 --include-stopped


echo "================================================================================"
echo "Installing Portainer"
cd $PATH_TO_SCRIPTS/portainer
sudo USED_DOCKER_DATA=$DOCKER_DATA docker-compose up -d


echo "================================================================================"
echo "Installing Nginx"
cd $PATH_TO_SCRIPTS/nginx
sudo USED_DOCKER_DATA=$DOCKER_DATA docker-compose up -d


echo "================================================================================"
echo "Installing Code-Server"
cd $PATH_TO_SCRIPTS/code-server
echo "================================================================================"
echo "Please enter a password for code-server"
read -s VSCODE_PASSWORD
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_VSCODE_PASSWORD=$VSCODE_PASSWORD docker-compose up -d


echo "================================================================================"
echo "Installing Gitea"
cd $PATH_TO_SCRIPTS/gitea
echo "================================================================================"
echo "Please enter a path to data for Gitea"
read GITEA_DATA
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_GITEA_DATA=$GITEA_DATA docker-compose up -d


echo "================================================================================"
echo "Installing Jellyfin, Deluge, Sonarr, Jacket and Radarr (all in one)"
cd $PATH_TO_SCRIPTS/media-services
echo "================================================================================"
echo "Please enter the path to your downloads"
read DOWNLOADS_PATH
echo "================================================================================"
echo "Please enter the path to your media"
read MEDIA_PATH
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_DOWNLOADS_PATH=$DOWNLOADS_PATH USED_MEDIA_PATH=$MEDIA_PATH docker-compose up -d


echo "================================================================================"
echo "Installing Lidarr-on-steroids"
cd $PATH_TO_SCRIPTS/lidarr-on-steroids
echo "================================================================================"
ehco "Please enter the path to your music"
read MUSIC_PATH
echo "================================================================================"
echo "Please enter the path to your downloads"
read DOWNLOADS_PATH
sudo USED_DOCKER_DATA=$DOCKER_DATA =$MUSIC_PATH USED_DOWNLOADS_PATH=$DOWNLOADS_PATH docker-compose up -d

:'
echo "================================================================================"
echo "Installing Navidrome"
cd $PATH_TO_SCRIPTS/navidrome
echo "================================================================================"
echo "Please enter the path to your music"
read MUSIC_PATH
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_MUSIC_PATH=$MUSIC_PATH docker-compose up -d
'

echo "================================================================================"
echo "Installing Papermerge"
cd $PATH_TO_SCRIPTS/papermerge
echo "================================================================================"
echo "Please enter the path to your documents"
read DOCUMENTS_PATH
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_DOCUMENTS_PATH=$DOCUMENTS_PATH docker-compose up -d


echo "================================================================================"
echo "Installing FreshRss"
cd $PATH_TO_SCRIPTS/freshrss
sudo USED_DOCKER_DATA=$DOCKER_DATA docker-compose up -d


echo "================================================================================"
echo "List all docker running containers"
sudo docker ps
