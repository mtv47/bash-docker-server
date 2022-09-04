#!/bin/bash


cat << "EOF"
______     _     _             
|  _  \   | |   (_)            
| | | |___| |__  _  __ _ _ __  
| | | / _ | '_ \| |/ _` | '_ \ 
| |/ |  __| |_) | | (_| | | | |
|___/ \___|_.__/|_|\__,_|_| |_|
                               
                               
EOF

echo ""
echo "Script by mtv47 to set up a debian server with docker"
echo ""

USER_HOME=$(eval echo ~${SUDO_USER})
PATH_TO_SCRIPTS="$USER_HOME/bash-nuc"

echo ""
echo "This script will be working in"
echo $USER_HOME
echo ""

options=("Basic Setup" "Installs for Docker" "Installs for Docker Containers" "Update" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Basic Setup")
            bash basic.sh
            ;;
        "Installs for Docker")
            bash docker.sh
            ;;
        "Installs for Docker Containers")
            bash containers.sh
            ;;
        "Update")
            bash update.sh
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done