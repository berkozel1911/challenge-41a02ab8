#!/usr/bin/env bash

set -e

echo -e '\n[info] Starting the k3s installer...\n'
echo -e '\n[info] Turning off the UFW firewall (recommended by k3s)\n'

ufw disable
# TODO allow ports

# TODO check available memory
# TODO check available CPU cores

echo -e '\n[info] Ensuring curl is installed on system.\n'

apt install -y curl

echo -e "\n[info] Starting k3s' official installation script (ref: https://get.k3s.io)\n"

curl -sfL https://get.k3s.io | sh -

echo -e "\n[info] Checking k3s service after the installation.\n"
echo -e "\n[info] k3s service status:" $(systemctl is-active k3s) "\n"

echo -e "\n[info] Adding KUBECONFIG path variable to .bashrc"

echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc
