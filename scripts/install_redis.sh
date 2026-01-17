#!/usr/bin/env bash

set -e

echo -e "\n[info] Installing Redis with Helm\n"
helm install redis bitnami/redis -n $NAMESPACE_ID -f $1 # Takes the first argument as Helm variable file.

