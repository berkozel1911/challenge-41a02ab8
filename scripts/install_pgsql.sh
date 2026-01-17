#!/usr/bin/env bash

set -e

echo -e "\n[info] Installing PostgreSQL with Helm\n"
helm install postgres bitnami/postgresql -n ns0 --create-namespace -f $1 # Takes the first argument as Helm variable file.

