#!/bin/bash
set -e
apt update
apt install -y nginx
echo "Compute VM instance is deployed" > /var/www/html/index.html
ufw allow '${ufw_allow_nginx}'
systemctl enable nginx
systemctl restart nginx
