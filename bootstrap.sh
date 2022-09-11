#!/bin/bash
# A bash script that prepares the OS
# before running the scripts

# Detect OS
if grep -qs "ubuntu" /etc/os-release; then
  os="ubuntu"
  os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
else
  echo "This installer seems to be running on an unsupported distribution."
  echo "Supported distros are Ubuntu 20.04 and 22.04"
  exit
fi

# Check if the Ubuntu version is too old
if [[ "$os" == "ubuntu" && "$os_version" -lt 2004 ]]; then
  echo "Ubuntu 20.04 or higher is required to use this installer."
  echo "This version of Ubuntu is too old and unsupported."
  exit
fi

# Check if the user is root
if [ "$EUID" -ne 0 ]; then
  echo "This installer needs to be run as root."
  exit
fi

# Clones the repository
[ -d "$HOME/bash-docker-server" ] || git clone https://github.com/mtv47/bash-docker-server.git $HOME/bash-docker-server

cd $HOME/bash-docker-server

clear
sudo bash init.sh
