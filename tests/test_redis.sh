#!/usr/bin/env bash

set -e

# TODO take port number from ymls
# TODO take password from ymls
# TODO add passed arguments number check

echo -e "\n[info] Testing Redis connection...\n"

if redis-cli -h $(hostname -I | awk '{ print $1 }') -p 30379 -a Password1. ping 2>/dev/null; then
	echo -e "\n[info] Redis is active and listening connections from outside of the k3s cluster."
else
	echo -e "\n[ERR] Redis connection test is failed."
fi
