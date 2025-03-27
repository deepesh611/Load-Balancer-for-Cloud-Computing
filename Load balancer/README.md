# Nginx Load Balancer Setup for Raspberry Pi Cluster

This project sets up an **Nginx reverse proxy** on a Raspberry Pi cluster to distribute traffic between multiple nodes.

## 🚀 Features
- Load balancing between multiple Raspberry Pi nodes
- Automatic failover (if a node is down, traffic is rerouted)
- Custom Nginx configuration with **reverse proxying**
- Simple setup script for automation

---

## 📦 Installation & Setup

### 1️⃣ **Clone the Repository**
```sh
git clone https://github.com/deepesh611/Load-Balancer-for-Cloud-Computing.git
cd Load-Balancer-for-Cloud-Computing
```

### 2️⃣ Run the Setup Scripts
```sh
chmod +x initial_setup.sh
./initial_setup.sh

chmod +x loadbalancer_setup.sh
./loadbalancer_setup.sh
```

### 3️⃣ Verify the Setup
Check Nginx status:
```sh
sudo systemctl status nginx
```
If everything is fine, you should see `active (running)`.

## ⚙️ Configuration
### 🔹 Nginx Configuration Path
The main configuration file is located at: `/etc/nginx/nginx.conf`
By default, the original config is backed up as: `/etc/nginx/nginx_original.conf`

### 🔹 Adding More Nodes
To add more backend servers, edit `/etc/nginx/nginx.conf` on the Load Balancer:

```sh
upstream backend {
    server 192.168.1.2;  # Node 1
    server 192.168.1.3;  # Node 2
}
```

Then restart Nginx:
```sh
sudo systemctl restart nginx
```

## 🤝 Contributing
Pull requests are welcome! If you have ideas to improve this setup, feel free to submit a PR.
