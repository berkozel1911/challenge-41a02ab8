#!/usr/bin/env bash


set -e

# Write backup procedures under /usr/local/bin/backup_pgsql.sh when install.sh runs.
# Since the backup procedures depends on variables like PostgreSQL superuser password, when install.sh runs
# the values will be created dynamically sourced by env.sh
# For example, observe the contents of /usr/local/bin/backup_pgsql.sh after running install.sh

## Create backup directory when the cronjob runs everytime.
echo "mkdir -p $PGSQL_BACKUP_DIR" > /usr/local/bin/backup_pgsql.sh

# Execute shell in the postgresql pod take a dump as superuser. Take the dump to /tmp/pgsql_dump.sql
echo "kubectl exec -it postgres-postgresql-0 -n $NAMESPACE_ID -- pg_dump postgresql://postgres:$PGSQL_ROOT_PW@127.0.0.1/$PGSQL_DB_NAME --file=/tmp/pgsql_dump.sql" >> /usr/local/bin/backup_pgsql.sh

# Copy taken dump file to host machine executing kubectl.
echo "kubectl cp $NAMESPACE_ID/postgres-postgresql-0:/tmp/pgsql_dump.sql $PGSQL_BACKUP_DIR/pgsql_backup-\$(date +%d_%m_%Y-%H_%M).sql" >> /usr/local/bin/backup_pgsql.sh

# Make only root can read contents of /usr/local/bin/backup_pgsql.sh
chown -v root:root /usr/local/bin/backup_pgsql.sh 

# Since at the cronjob the script will be called as Bash's arguments, no more permissions needs but read permission.
chmod 400 /usr/local/bin/backup_pgsql.sh

echo -e "\n[info] Installing PostgreSQL backup cron job\n"

# Register to root's crontab
echo "00 00 * * * /usr/bin/bash /usr/local/bin/backup_pgsql.sh" | crontab -

echo -e "\n[info] PostgreSQL backup job has been installed.\n"

echo -e "\n[info] PostgreSQL backup helper installation is completed.\n"
