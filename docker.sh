#!bin/bash

sudo apt-get update

echo "================================================================================"
echo "Update the apt package index"
#and install packages to allow apt to use a repository over HTTPS
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "================================================================================"
echo "Add Docker’s official GPG key"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "================================================================================"
echo "Set up the repository"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "================================================================================"
echo "In case the repository is not available yet, add the GPG key manually"
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "================================================================================"
echo " Adding the linux user to the docker group"
sudo usermod -aG docker $USER

echo "================================================================================"
echo "Installing the lastest version of docker engine"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "================================================================================"
echo "Verify if docker is installed"
sudo docker --version
sudo docker run hello-world

echo "================================================================================"
echo "Verify if docker-compose is installed"
docker compose version
