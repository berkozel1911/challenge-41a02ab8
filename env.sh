#!/usr/bin/env bash

export NAMESPACE_ID=ns0 # Namespace ID of k3s cluster

export PGSQL_ROOT_PW=SuperSecretPassword # PostgreSQL superuser (postgres) password 
export PGSQL_USER=dbuser # PostgreSQL normal username
export PGSQL_USER_PW=SuperSecretPassword # PostgreSQL normal user password
export PGSQL_DB_NAME=db0 # Initial database for normal user
export PGSQL_BACKUP_DIR=/var/backups/db0/pgsql # Path on hostname for PostgreSQL backups

export REDIS_ROOT_PW=SuperSecretPassword # Redis superuser password
