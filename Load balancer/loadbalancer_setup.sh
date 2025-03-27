#!/bin/bash

# Colors
NC='\033[0m' 
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'

echo -e "${YELLOW}Backing up the original Nginx config...${NC}"
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx_original.conf

echo -e "${YELLOW}Copying the new Nginx config from the repository...${NC}"
sudo cp nginx.conf /etc/nginx/nginx.conf

echo -e "${YELLOW}Restarting Nginx to apply changes...${NC}"
sudo systemctl restart nginx

# Check if Nginx is running
if systemctl is-active --quiet nginx; then
    echo -e "${GREEN}Nginx setup complete and running!${NC}"
else
    echo -e "${RED}Nginx failed to restart! Check logs using: sudo journalctl -u nginx --no-pager${NC}"
    echo -e "Press Enter to Continue ..."
    read -r
    exit 1
fi

echo -e "${GREEN}Setup complete. You can check Nginx status using:${NC} sudo systemctl status nginx"
echo -e "\n${GREEN}You can check Nginx logs using:${NC} sudo journalctl -u nginx --no-pager"
echo -e "${GREEN}You can check Nginx config using:${NC} sudo cat /etc/nginx/nginx.conf"
