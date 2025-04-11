# 🌨️ Load Balancer for Cloud Computing

This project demonstrates a failover load balancer setup using `Docker`, `Keepalived`, and `Portainer`, running on two devices. It includes a basic HTML site hosted in Docker containers, with a virtual IP (VIP) switching between main and backup servers for high availability, with negligible downtime.

## 📁 Project Structure
```bash
Load-Balancer-for-Cloud-Computing/
├── Docker/
│   ├── bkp_app.sh              # Setup script for backup server Docker container
│   ├── main_app.sh             # Setup script for main server Docker container
│   ├── Dockerfile              # Common Dockerfile for both servers
│   ├── initial setup.sh        # Docker environment setup
│   ├── portainer_main.sh       # Portainer setup for main server
│   └── portainer_agent.sh      # Portainer agent for remote control
│
├── Load balancer/
│   ├── initial_setup.sh        # Basic packages and dependencies
│   ├── loadbalancer_setup.sh   # Keepalived and VIP configuration
│   ├── nginx.conf              # Nginx load balancer config (optional)
│   ├── README.md               # Load balancer notes
│   └── tools.txt               # Tool list for load balancer
│
├── Servers/
│   ├── backup.html             # HTML for backup server
│   ├── master.html             # HTML for main server
│   ├── backupServer.sh         # Legacy backup server script (non-docker)
│   ├── masterServer.sh         # Legacy main server script (non-docker)
│   └── tools.txt               # Common tools/scripts
│
├── Papers/                     # Related research papers or documentation
│
├── LICENSE
└── README.md                   
```

## 🧠 What It Does
- Uses `keepalived` for virtual IP failover
- Hosts a basic HTML web page using Docker containers
- Includes Portainer for container visualization and management
- Automatically switches to the backup server if the main goes down


## 💡 Setup Instructions
### 1. 🔧 Docker & Portainer
On both servers:
```bash
# Run this once to install Docker & Portainer
cd Docker
sudo bash initial\ setup.sh
```
On Main Server:
```bash
sudo bash portainer_main.sh
```
On Backup Server
```bash
sudo bash portainer_agent.sh
```

### 2. 🛠 Main & Backup Containers
On Main Server:
```bash
sudo bash main_app.sh
```
On Backup Server:
```bash
sudo bash bkp_app.sh
```

### 3. 🌐 Load Balancer & VIP (Keepalived)
On both servers:
```bash
cd ../Load\ balancer
sudo bash initial_setup.sh
sudo bash loadbalancer_setup.sh
```

## 🔍 Access
| **TYPE** | **URL/IP**                              |
|-|-----------------------------------------|
| Virtual IP | http://<virtual-ip>                     |
| Main Page | Custom HTML page with unique color + header |
| Backup Page | 	Custom HTML page with different look   |
| Portainer | 	http://<main-server-ip>:9000           |

## 📦 Docker Image Info
Both servers use the same Dockerfile to serve their respective HTML pages. Pages are placed dynamically by the scripts (`main_app.sh` / `bkp_app.sh`).


## 📌 Notes
- Restart policy is set to `unless-stopped` for container resilience.
- Keepalived monitors the health and performs VIP handoff.
- No external database is used—only static HTML.

## Results

<img src="./assets/Screenshot 2025-04-11 154300.png">
<img src="./assets/Screenshot 2025-04-11 154315.png">
<img src="./assets/Screenshot 2025-04-11 154241.png">
<img src="./assets/Screenshot 2025-04-11 154832.png">