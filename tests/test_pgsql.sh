#!/usr/bin/env bash

set -e

echo -e "\n[info] Testing PostgreSQL connection...\n"

# Since this is a connection test from outside of the k3s cluster, 
# -h argument takes the IP address of the running machine from the network interface.
# e.g 192.168.1.10 instead of 127.0.0.1
if pg_isready -U postgres -h $(hostname -I | awk '{ print $1 }') -p 30432; then
	echo -e "\n[info] PostgreSQL is active and listening connections from outside of the k3s cluster."
	exit 0;
else
	echo -e "\n[ERROR] PostgreSQL connection test is failed."
	exit 3
fi

