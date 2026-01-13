#!/usr/bin/env bash

set -e
helm install postgres bitnami/postgresql -n pgsql -f helm-postgres.yaml

