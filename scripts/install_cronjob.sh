#!/usr/bin/env bash

set -e

echo -e "\n[info] Installing PostgreSQL backup utilities.\n"

echo -e "\n[info] Installing PostgreSQL backup cron job handler\n"
cp -v ./cron/backup_pgsql.sh /usr/local/bin/backup_pgsql.sh

chown -v root:root /usr/local/bin/backup_pgsql.sh 
chmod 500 /usr/local/bin/backup_pgsql.sh

echo -e "\n[info] Installing PostgreSQL backup cron job\n"

echo "00 00 * * * bash /usr/local/bin/backup_pgsql.sh" | crontab -

echo -e "\n[info] PostgreSQL backup job has been installed.\n"