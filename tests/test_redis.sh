#!/usr/bin/env bash

set -e

echo -e "\n[info] Testing Redis connection...\n"

# Takes first argument ($1) as Redis root password.
# Since this is a connection test from outside of the k3s cluster, 
# -h argument takes the IP address of the running machine from the network interface.
# e.g 192.168.1.10 instead of 127.0.0.1
if redis-cli -h $(hostname -I | awk '{ print $1 }') -p 30379 -a $1 ping 2>/dev/null; then
	echo -e "\n[info] Redis is active and listening connections from outside of the k3s cluster."
else
	echo -e "\n[ERROR] Redis connection test is failed."
fi
