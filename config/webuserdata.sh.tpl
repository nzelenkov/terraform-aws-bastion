#!/bin/bash
export HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/hostname)
export PUBLIC_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
export FILE=/var/www/${app_dir}/index.html
sudo mkdir -p "$(dirname "$FILE")" && sudo touch "$FILE"
echo Hello from AWS Instance $HOSTNAME, with public IPv4 Address: $PUBLIC_IPV4 | sudo tee $FILE