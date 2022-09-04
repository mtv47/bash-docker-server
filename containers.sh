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
echo "Installing portainer"
cd $PATH_TO_SCRIPTS
cd $PATH_TO_SCRIPTS/portainer
sudo NOW_DOCKER_DATA=$DOCKER_DATA docker-compose up -d


echo "================================================================================"
echo "Installing Code-Server"
sudo docker run -d \
  --name=code \
  --network=nginx_default \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Paris \
  -e PASSWORD=wasd \
  -e SUDO_PASSWORD=F0x901901 \
  -v /home/mt/truenas/Config/server_config/code-server_config:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/code-server:latest


echo "================================================================================"
echo "Installing Deluge"
sudo docker run -d \
  --name=deluge \
  --network=nginx_default \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e DELUGE_LOGLEVEL=error `#optional` \
  -v /home/mt/truenas/Config/server_config/deluge_config:/config \
  -v /home/mt/truenas/Public/Torrent/Temp/Downloading:/downloads \
  --restart unless-stopped \
  lscr.io/linuxserver/deluge:latest


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

