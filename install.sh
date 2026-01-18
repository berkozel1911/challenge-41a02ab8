#!/usr/bin/env bash
set -e

echo -e "\n[info] Starting the installer...\n"

echo -e "\n[info] Setting up environment variables.\n"

source ./env.sh

# Setup postgres_helm_vars.yml variables
sed -i "s/CHANGE_POSTGRES_ROOT_PW/$PGSQL_ROOT_PW/" ./vars/postgres_helm_vars.yml
sed -i "s/CHANGE_POSTGRES_USERNAME/$PGSQL_USER/" ./vars/postgres_helm_vars.yml
sed -i "s/CHANGE_POSTGRES_USER_PW/$PGSQL_USER_PW/" ./vars/postgres_helm_vars.yml
sed -i "s/CHANGE_DB_NAME/$PGSQL_DB_NAME/" ./vars/postgres_helm_vars.yml

# Setup redis_helm_vars.yml variables
sed -i "s/CHANGE_REDIS_ROOT_PW/$REDIS_ROOT_PW/" ./vars/redis_helm_vars.yml

# Needed for Helm.
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> /etc/profile

# Run k3s installer
echo -e '\n[info] Installing k3s\n'
bash ./scripts/install_k3s.sh > /dev/null 2>&1

# Run Helm installer
echo -e '\n[info] Installing Helm\n'
bash ./scripts/install_helm.sh > /dev/null 2>&1

# Run PostgreSQL installer
echo -e '\n[info] Installing PostgreSQL to the local k3s cluster\n'
bash ./scripts/install_pgsql.sh $NAMESPACE_ID $(readlink -f ./vars/postgres_helm_vars.yml)

# Run Redis installer
echo -e '\n[info] Installing Redis to the local k3s cluster\n'
bash ./scripts/install_redis.sh $NAMESPACE_ID $(readlink -f ./vars/redis_helm_vars.yml)

# Install PostgreSQL backup cronjob.
echo -e "\n[info] Installing PostgreSQL periodic backup scripts.\n"
bash ./scripts/install_cronjob.sh

echo -e '\n[info] Installation complete.\n'

# Install test tools
echo -e "\n[info] Installing test tools.\n"
bash tests/test_utils.sh > /dev/null 2>&1

# Sleep 5 seconds before running tests to wait k3s pods get ready.
echo -e "\n[info] Waiting 60 seconds before running connectivity tests.\n"
sleep 60

# Run Postgres & Redis connectivity
echo -e "\n[info] Running connectivity tests.\n"
bash tests/test_pgsql.sh
bash tests/test_redis.sh $REDIS_ROOT_PW
