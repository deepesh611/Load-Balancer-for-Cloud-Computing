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
GREEN='\033[0;32m'

# Updating and Upgrading the Raspberry Pi
echo -e "\n${BLUE}🔄 Updating and upgrading the Raspberry Pi...${NC}\n"
sudo apt update && sudo apt upgrade -y
echo -e "\n${GREEN}✅ Update and upgrade complete.${NC}\n"

# Install the required tools from tools.txt
if [[ -f tools.txt ]]; then #checking if the tools file exists
    echo -e "${BLUE}📂 Found tools.txt. Installing required packages...${NC}\n"
    grep -vE '^\s*#|^\s*$' tools.txt | xargs sudo apt install -y
    echo -e "\n${GREEN}✅ Installation complete.${NC}\n"

    # Enable the required services
    echo -e "${BLUE}🔌 Enabling required services...${NC}\n"
    sudo systemctl start nginx
    sudo systemctl enable nginx
else
    echo -e "\n${RED}❌ tools.txt not found! Exiting...${NC}\n"
    exit 1
fi

echo -e "\n${GREEN}🎉 Setup complete! Press Enter to continue...${NC}" 
read -r
