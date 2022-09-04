#!/bin/bash

echo "================================================================================"
echo "Update and Upgrade"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo "================================================================================"
echo "Unattended-upgrades"
sudo unattended-upgrade --debug

echo "================================================================================"
echo "Updating Dockers"
sudo docker start watchtower