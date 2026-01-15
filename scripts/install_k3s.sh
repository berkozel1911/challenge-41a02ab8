#!/usr/bin/env bash

set -e

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

cat << EOF

---
Ensuring curl is installed on system.
---

EOF

apt update && apt install -y curl

cat << EOF

---
Starting k3s' official installation script (ref: https://get.k3s.io)
---

EOF
curl -sfL https://get.k3s.io | sh -

echo "---"
echo "Checking k3s service after the installation."
echo "k3s service status:" $(systemctl is-active k3s)
echo "---"

cat << EOF

---
Adding KUBECONFIG path variable to .bashrc
---

EOF

echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc
