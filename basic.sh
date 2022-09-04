#!/bin/bash

echo "================================================================================"
echo "Update and Upgrade"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo "================================================================================"
echo "Installing basics"
sudo apt install nano cifs-utils -y

echo "================================================================================"
echo "unattended-upgrades"
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure --priorit=low unattended-upgrades

echo "================================================================================"
echo "Testing if unattended-upgrades is working"
sudo unattended-upgrade --debug

echo "================================================================================"
echo "Installing Fail2Ban"
sudo apt install fail2ban -y
sudo systemctl enable fail2ban --now

echo "================================================================================"
echo "Testing if Fail2Ban is working"
sudo systemctl status fail2ban
sudo fail2ban-client status
sudo fail2ban-client status sshd

echo "================================================================================"
echo "Installing UFW"
sudo apt install ufw -y
sudo ufw default allow outgoing
sudo ufw default deny incoming
echo "================================================================================"
echo "Allowing port"
sudo ufw allow ssh
sudo ufw allow 9443
sudo ufw allow 80
sudo ufw allow 81
sudo ufw allow 443
echo "================================================================================"
echo "Enabling UFW"
sudo ufw enable