#!/usr/bin/env bash

cat << EOF

---
Starting Helm installer...
---

EOF

# Ensure prerequisite packages has been installed
apt install -y curl gpg apt-transport-https

echo "Installing Helm GPG keys..."
curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null

echo "Adding Helm repository to /etc/apt/sources.list"
echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

echo "Running apt update"
apt update

echo "Installing Helm"
apt -y install helm

echo "Adding Bitnami's Helm repo"
helm repo add bitnami https://charts.bitnami.com/bitnami

echo "Updating Helm repo caches..."
helm repo update

