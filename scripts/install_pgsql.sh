#!/usr/bin/env bash

# Arguments for this script:
# $1: Namespace name, default is NAMESPACE_ID @env.sh
# $2: Helm variables file path

set -e

echo -e "\n[info] Installing PostgreSQL with Helm\n"
helm install postgres bitnami/postgresql -n $1 --create-namespace -f $2

echo -e "\n[info] PostgreSQL installation is completed.\n"