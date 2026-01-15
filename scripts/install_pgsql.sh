#!/usr/bin/env bash

set -e
helm install postgres bitnami/postgresql -n ns0 --create-namespace -f helm-postgres.yaml

