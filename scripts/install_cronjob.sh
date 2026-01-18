#!/usr/bin/env bash

set -e

mkdir -p $PGSQL_BACKUP_DIR

echo "kubectl exec -it postgres-postgresql-0 -n $NAMESPACE_ID -- pg_dump -U postgres -d $PGSQL_DB_NAME --file=/var/tmp/pgsql_backup.sql" > /usr/local/bin/backup_pgsql.sh
echo "kubectl cp $NAMESPACE_ID/postgres-postgresql-0:/var/tmp/pgdump.sql PGSQL_BACKUP_DIR/pgsql_backup-$(date +%d_%m_%Y-%H_%M).sql" >> /usr/local/bin/backup_pgsql.sh

chown -v root:root /usr/local/bin/backup_pgsql.sh 
chmod 400 /usr/local/bin/backup_pgsql.sh

echo -e "\n[info] Installing PostgreSQL backup cron job\n"

echo "00 00 * * * /usr/bin/bash /usr/local/bin/backup_pgsql.sh" | crontab -

echo -e "\n[info] PostgreSQL backup job has been installed.\n"

echo -e "\n[info] PostgreSQL backup helper installation is completed.\n"