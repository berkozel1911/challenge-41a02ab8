#!/usr/bin/env bash

set -e

echo -e "\n[info] Writing PostgreSQL periodic backup scripts.\n"

mkdir -p $PGSQL_BACKUP_DIR

echo "kubectl exec -it postgres-postgresql-0 -n $NAMESPACE_ID -- pg_dump -U postgres -d $PGSQL_ROOT_PW --file=/var/tmp/pgdump.sql" > /usr/local/bin/backup_pgsql.sh
echo "kubectl cp ns0/postgres-postgresql-0:/var/tmp/pgdump.sql /var/backups/db0/pgsql" >> /usr/local/bin/backup_pgsql.sh

chown -v root:root /usr/local/bin/backup_pgsql.sh 
chmod 500 /usr/local/bin/backup_pgsql.sh

echo -e "\n[info] Installing PostgreSQL backup cron job\n"

echo "00 00 * * * bash /usr/local/bin/backup_pgsql.sh" | crontab -

echo -e "\n[info] PostgreSQL backup job has been installed.\n"