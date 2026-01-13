#!/usr/bin/env bash

set -e
helm install postgres bitnami/postgresql -n database -f values.yaml

