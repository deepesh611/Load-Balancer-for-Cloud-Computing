#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo -e "\n${RED}❌ This script must be run as root! \n"
    echo -e "${BLUE}🔑 Please run the script with sudo.${NC}\nPress Enter..."
    read -r
    exit 1
fi

# Color codes
NC='\033[0m'
RED='\033[0;31m'
BLUE='\033[0;34m'

# Updating and Upgrading the Raspberry Pi
echo -e "\n${BLUE}🔄 Updating the Raspberry Pi...${NC}\n"
sudo apt update && sudo apt upgrade -y

# Install Docker
echo -e "\n${BLUE}Installing Docker...${NC}\n"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER


