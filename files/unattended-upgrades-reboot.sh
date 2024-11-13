#!/bin/bash

# /usr/local/bin/unattended-upgrades-reboot.sh

# Variables
REBOOT_TIMESTAMP_FILE="/var/log/last_unattended_reboot"
REBOOT_INTERVAL_SECONDS=1209600  # 2 weeks

# Check if a reboot is required
if [ -f /var/run/reboot-required ]; then
    CURRENT_TIMESTAMP=$(date +%s)

    if [ -f "$REBOOT_TIMESTAMP_FILE" ]; then
        LAST_REBOOT_TIMESTAMP=$(cat "$REboot_TIMESTAMP_FILE")
        DIFF=$((CURRENT_TIMESTAMP - LAST_REBOOT_TIMESTAMP))
        if [ "$DIFF" -ge "$REBOOT_INTERVAL_SECONDS" ]; then
            echo "$CURRENT_TIMESTAMP" > "$REBOOT_TIMESTAMP_FILE"
            /sbin/shutdown -r now
        fi
    else
        # Timestamp file doesn't exist; create it and reboot
        echo "$CURRENT_TIMESTAMP" > "$REBOOT_TIMESTAMP_FILE"
        /sbin/shutdown -r now
    fi
fi
