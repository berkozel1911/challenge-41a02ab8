#!/usr/bin/env bash

set -e

mkdir -p /var/backups/db0/pgsql

kubectl exec -it postgres-postgresql-0 -n ns0 -- pg_dump -U postgres -d db0 --file=/var/tmp/pgdump.sql
kubectl cp ns0/postgres-postgresql-0:/var/tmp/pgdump.sql /var/backups/db0/pgsql