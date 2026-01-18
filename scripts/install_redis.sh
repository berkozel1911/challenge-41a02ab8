#!/usr/bin/env bash

# Install Redis inside k3s cluster namespace using Helm
# Arguments for this script:
# $1: Namespace name, default is NAMESPACE_ID @env.sh
# $2: Helm variables file path

set -e

echo -e "\n[info] Installing Redis with Helm\n"
helm install redis bitnami/redis -n $1 -f $2 # Takes the first argument as Helm variable file.

echo -e "\n[info] Redis installation is completed.\n"