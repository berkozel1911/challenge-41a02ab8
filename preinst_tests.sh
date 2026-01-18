#!/usr/bin/env bash

set -e

echo -e "\n[info] Checking the script is running as root user...\n"

# Check if the script running as root user.
if [[ $EUID -ne 0 ]]; then # Check running user does not have the UID as 0, which means running as whether root user.
   echo "\n[ERROR] This script must be running as root. Exiting...\n" 
   exit 1 # Terminate the script with exit code 1.
fi

# Check internet connection
echo -e "\n[info] Checking internet connection."
ping google.com -c 4 >/dev/null 2>&1

# If the exit status of the ping command above is anything than 0, then there is no internet connection.
if [ $? -ne 0 ]; then
	echo -e "\n[ERROR] This script requires active internet connection. Exiting...\n"
	exit 2 # Terminate the script with exit code 2.
fi
