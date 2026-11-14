#!/usr/bin/env bash

# Test disk status with different values

check_disk() {
    if [ "$DISK_NUMBER" -ge 80 ]; then
        STATUS="WARNING"
    else
        STATUS="OK"
    fi
}

DISK_NUMBER=50
check_disk
echo "50% = $STATUS"

DISK_NUMBER=80
check_disk
echo "80% = $STATUS"

DISK_NUMBER=90
check_disk
echo "90% = $STATUS"
