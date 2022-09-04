#!/bin/bash

PATH_TO_SCRIPTS="$HOME/bash-debian-server"
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
echo "Install Homarr"
cd $PATH_TO_SCRIPTS/homarr
sudo USED_DOCKER_DATA=$DOCKER_DATA docker-compose up -d


echo "================================================================================"
echo "Installing Code-Server"
cd $PATH_TO_SCRIPTS
cd $PATH_TO_SCRIPTS/code-server
#Ask user for a password
echo "Please enter a password for code-server"
read -s VSCODE_PASSWORD
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_VSCODE_PASSWORD=$VSCODE_PASSWORD docker-compose up -d


echo "================================================================================"
echo "Installing Gitea"
cd $PATH_TO_SCRIPTS/gitea
#Ask user for a path to data
echo "Please enter a path to data for Gitea"
read GITEA_DATA
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_GITEA_DATA=$GITEA_DATA docker-compose up -d


echo "================================================================================"
echo "Installing Deluge"
cd $PATH_TO_SCRIPTS/deluge
#Ask for the path of the downloads
echo "Please enter the path to your downloads"
read DOWNLOADS_PATH
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_DOWNLOADS_PATH=$DOWNLOADS_PATH docker-compose up -d


echo "================================================================================"
echo "Installing Jellyfin"
cd $PATH_TO_SCRIPTS/jellyfin
#Ask for the path of the media
echo "Please enter the path to your media"
read MEDIA_PATH
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_MEDIA_PATH=$MEDIA_PATH docker-compose up -d


echo "================================================================================"
echo "Installing Navidrome"
cd $PATH_TO_SCRIPTS/navidrome
#Ask for the path of the music
echo "Please enter the path to your music"
read MUSIC_PATH
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_MUSIC_PATH=$MUSIC_PATH docker-compose up -d


echo "================================================================================"
echo "Installing Papermerge"
cd $PATH_TO_SCRIPTS/papermerge
#Ask for the path of the documents$
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



