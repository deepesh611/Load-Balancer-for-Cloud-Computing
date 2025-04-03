#!/bin/bash

# Configuration
VIRTUAL_IP="192.168.1.100"  # Change to your Virtual IP
NETWORK_INTERFACE="eth0"  # Change if using Wi-Fi or another interface
AUTH_PASS="mysecurepassword"  # Change for security
PRIORITY=100  # Higher priority for Master
STATE="MASTER"

# Install Keepalived
echo "Installing Keepalived on MASTER..."
sudo apt update && sudo apt install -y keepalived

# Create SSH Health Check Script
echo "Creating SSH health check script..."
cat <<EOF | sudo tee /etc/keepalived/check_ssh.sh > /dev/null
#!/bin/bash
if ! systemctl is-active --quiet ssh; then
    exit 1
fi
exit 0
EOF

# Create Main Service Health Check Script
echo "Creating main service health check script..."
cat <<EOF | sudo tee /etc/keepalived/check_service.sh > /dev/null
#!/bin/bash
if ! pgrep -x "nginx" > /dev/null; then  # Change "nginx" to your actual service
    exit 1
fi
exit 0
EOF

# Make scripts executable
sudo chmod +x /etc/keepalived/check_ssh.sh
sudo chmod +x /etc/keepalived/check_service.sh

# Configure Keepalived
echo "Configuring Keepalived for MASTER..."
cat <<EOF | sudo tee /etc/keepalived/keepalived.conf > /dev/null
vrrp_script check_ssh {
    script "/etc/keepalived/check_ssh.sh"
    interval 2
    weight -20
}

vrrp_script check_service {
    script "/etc/keepalived/check_service.sh"
    interval 2
    weight -20
}

vrrp_instance VI_1 {
    state $STATE
    interface $NETWORK_INTERFACE
    virtual_router_id 51
    priority $PRIORITY
    advert_int 1

    authentication {
        auth_type PASS
        auth_pass $AUTH_PASS
    }

    virtual_ipaddress {
        $VIRTUAL_IP
    }

    track_script {
        check_ssh
        check_service
    }
}
EOF

# Restart Keepalived
echo "Restarting Keepalived on MASTER..."
sudo systemctl restart keepalived
sudo systemctl enable keepalived

echo "MASTER setup completed."
