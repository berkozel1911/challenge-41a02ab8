#!/usr/bin/env bash

set -e

echo -e "\n[info] Testing PostgreSQL connection...\n"

# TODO take port number from ymls.

if pg_isready -U postgres -h $(hostname -I | awk '{ print $1 }') -p 30432; then
	echo -e "\n[info] PostgreSQL is active and listening connections from outside of the k3s cluster."
	exit 0;
else
	echo -e "\n[ERR] PostgreSQL connection test is failed."
fi

