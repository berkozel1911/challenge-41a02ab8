#!/usr/bin/env bash

echo -e '\n[info] Starting Helm installer...\n'


# Ensure prerequisite packages has been installed
apt install -y curl gpg apt-transport-https

echo -e "\n[info] Installing Helm GPG keys...\n"
curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null

echo -e "\n[info] Adding Helm repository to /etc/apt/sources.list\n"
echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

echo -e "\n[info] Running apt update\n"
apt update > /dev/null 2>&1

echo -e "\n[info] Installing Helm\n"
apt -y install helm

echo -e "\n[info] Adding Bitnami's Helm repo\n"
helm repo add bitnami https://charts.bitnami.com/bitnami

echo -e "\n[info] Updating Helm repo caches...\n"
helm repo update

