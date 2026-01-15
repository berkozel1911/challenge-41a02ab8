#!/usr/bin/env bash

set -e

echo -e "\n[info] Installing Redis from Helm\n"
helm install redis bitnami/redis -n ns0 -f $1

