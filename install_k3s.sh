#!/usr/bin/env bash

echo "Starting k3s installation..."

cat << EOF

---
Turning off the UFW firewall (recommended by k3s)
---
EOF

ufw disable
# TODO allow ports

# TODO check available memory
# TODO check available CPU cores

echo "Ensuring curl is installed on system."
apt update && apt install -y curl

curl -sfL https://get.k3s.io | sh -

systemctl status k3s

