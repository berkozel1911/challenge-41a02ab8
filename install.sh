#!/usr/bin/env bash
set -e

# TODO check the OS is Ubuntu 24.04 

echo "Starting the installer..."

# Check if the script running as root user.
if [[ $EUID -ne 0 ]]; then # Check running user does not have the UID as 0, which means running as whether root user.
   echo "This script must be running as root. Exiting..." 
   exit 1 # Terminate the script with exit code 1.
fi

# Needed for Helm.
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Run k3s installer
echo -e '\nInstalling k3s\n'
bash ./scripts/install_k3s.sh

# Run Helm installer
echo -e '\nInstalling Helm\n'
bash ./scripts/install_helm.sh

# Run PostgreSQL installer
echo -e '\nInstalling PostgreSQL inside the local k3s cluster\n'
bash ./scripts/install_pgsql.sh $(readlink -f ./vars/postgres_helm_vars.yml)

# Run Redis installer
echo -e '\nInstalling Redis inside the local k3s cluster\n'
bash ./scripts/install_redis.sh $(readlink -f ./vars/redis_helm_vars.yml)

echo -e '\nInstallation complete.\n'