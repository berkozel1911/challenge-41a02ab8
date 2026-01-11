#!/usr/bin/env bash

echo "Starting the local Kubernetes installer..."

# Check if the script running as root user.
if [[ $EUID -ne 0 ]]; then # Check running user does not have the UID as 0, which means running as whether root user.
   echo "This script must be running as root. Exiting..." 
   exit 1 # Terminate the script with exit code 1.
fi
