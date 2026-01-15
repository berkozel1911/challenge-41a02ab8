#!/usr/bin/env bash

set -e

helm install redis bitnami/redis -n ns0 -f helm-redis.yml

