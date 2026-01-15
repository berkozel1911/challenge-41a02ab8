#!/usr/bin/env bash

set -e

echo -e "\n[info] Installing PostgreSQL from Helm\n"
helm install postgres bitnami/postgresql -n ns0 --create-namespace -f $1

