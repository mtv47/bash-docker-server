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
echo "Installing Code-Server"
cd $PATH_TO_SCRIPTS
cd $PATH_TO_SCRIPTS/code-server
#Ask user for a password
echo "Please enter a password for code-server"
read -s VSCODE_PASSWORD
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_VSCODE_PASSWORD=$VSCODE_PASSWORD docker-compose up -d


echo "================================================================================"
echo "Installing Jellyfin"
cd $PATH_TO_SCRIPTS/jellyfin
#Ask for the path of the media
echo "Please enter the path to your media"
read MEDIA_PATH
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_MEDIA_PATH=$MEDIA_PATH docker-compose up -d


echo "================================================================================"
echo "Installing Deluge"
cd $PATH_TO_SCRIPTS/deluge
#Ask for the path of the downloads
echo "Please enter the path to your downloads"
read DOWNLOADS_PATH
sudo USED_DOCKER_DATA=$DOCKER_DATA USED_DOWNLOADS_PATH=$DOWNLOADS_PATH docker-compose up -d


echo "================================================================================"
echo "Installing File-Manager"
sudo docker run -d \
  --name=file-manager \
  --network=nginx_default \
  -v /home/mt/truenas/Config/server_data/file-manager_data/database.db:/database.db \
  -v /home/mt/truenas/:/srv \
  --user 1000:1000 \
  --restart unless-stopped \
  filebrowser/filebrowser:latest


echo "================================================================================"
echo "Installing Homer Docker"
sudo docker run -d \
  --name=homer \
  --network=nginx_default \
  -v /home/mt/truenas/Config/server_assets/homer_assets:/www/assets \
  --restart=always \
  b4bz/homer:latest


echo "================================================================================"
echo "Installing Jellyfin"
sudo docker run -d \
 --name jellyfin \
 --user 1000:1000 \
 --network=nginxproxymanager_default \
 --volume /home/mt/jellyfin/jellyfin_config:/config \
 --volume /home/mt/jellyfin/jellyfin_cache:/cache \
 --mount type=bind,source=/home/mt/truenas/Public/Torrent/Shows,target=/tv \
 --mount type=bind,source=/home/mt/truenas/Public/Torrent/Movie,target=/movie \
 --mount type=bind,source=/home/mt/truenas/Public/Torrent/Porn,target=/porn \
 --mount type=bind,source=/home/mt/truenas/Public/Torrent/Temp,target=/temp \
 --mount type=bind,source=/home/mt/truenas/Public/Torrent/Media,target=/media \
 --restart=unless-stopped \
 jellyfin/jellyfin:latest


echo "================================================================================"
echo "Installing Navidrome"
sudo docker run -d \
   --name navidrome \
   --network=nginxproxymanager_default \
   --restart=unless-stopped \
   --user $(id -u):$(id -g) \
   -v /home/mt/truenas/Public/Torrent/Music:/music \
   -v /home/mt/navidrome:/data \
   -e ND_LOGLEVEL=info \
   deluan/navidrome:latest


echo "================================================================================"
echo "List all docker running containers"
sudo docker ps

