#!/usr/bin/env bash

echo "Starting k3s installation..."

cat << EOF

---
Turning off the UFW firewall (recommended by k3s)
---
EOF

ufw disable
# TODO allow ports
