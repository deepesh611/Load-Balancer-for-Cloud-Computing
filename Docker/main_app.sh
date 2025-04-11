#!/bin/bash

# Exit on error
set -e

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

# Present working Directory
repo_path="$(pwd)"

# Check if run as root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}[✘] Please run as root or with sudo${RESET}"
    exit 1
fi

echo -e "${YELLOW}[*] Creating project directory...${RESET}"
mkdir -p ~/site-main
cd ~/site-main

echo -e "${YELLOW}[*] Writing index.html...${RESET}"
cp "$repo_path/../Servers/master.html" index.html

echo -e "${YELLOW}[*] Writing Dockerfile...${RESET}"
cp $repo_path/Dockerfile Dockerfile

echo -e "${YELLOW}[*] Building Docker image 'main-html-site'...${RESET}"
docker build -t main-site .

echo -e "${YELLOW}[*] Running Docker container 'main_web'...${RESET}"
docker run -d \
  --name main_web \
  -p 80:80 \
  --restart unless-stopped \
  main-site

echo -e "${GREEN}[✓] Main server container is now running on port 80${RESET}"
