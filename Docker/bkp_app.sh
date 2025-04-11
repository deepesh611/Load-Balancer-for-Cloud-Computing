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
mkdir -p ~/site-backup
cd ~/site-backup

echo -e "${YELLOW}[*] Writing index.html...${RESET}"
cp "$repo_path/../Servers/backup.html" index.html

echo -e "${YELLOW}[*] Writing Dockerfile...${RESET}"
cp "$repo_path/Dockerfile" Dockerfile

echo -e "${YELLOW}[*] Building Docker image 'backup-site'...${RESET}"
docker build -t backup-site .

echo -e "${YELLOW}[*] Cleaning up any existing 'backup_web' container...${RESET}"
docker rm -f backup_web 2>/dev/null || true

echo -e "${YELLOW}[*] Running Docker container 'backup_web'...${RESET}"
docker run -d \
  --name backup_web \
  -p 80:80 \
  --restart unless-stopped \
  backup-site

echo -e "${GREEN}[✓] Backup server container is now running on port 80${RESET}"
