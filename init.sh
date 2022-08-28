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

echo "Please enter your choice: "
options=("Installs for Docker" "Installs for Docker Containers")

select opt in "${options[@]}"
do
    case $opt in
        "Basic Setup")
            sudo bash basic.sh
            ;;
        "Installs for Docker")
            sudo bash docker.sh
            ;;
        "Installs for Docker Containers")
            sudo bash containers.sh
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done