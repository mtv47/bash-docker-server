#!/bin/bash

PATH_TO_SCRIPTS="$HOME/bash-debian-server"
PATH_TO_SERVER_DATA= $HOME/truenas/Config/server_data

#Installing portainer
cd $PATH_TO_SCRIPTS
mkdir $PATH_TO_SERVER_DATA/portainer_data
cd portainer
docker-compose up -d