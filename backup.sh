#!/bin/bash


location="$1"
backup_options="-avb"
if [ -d "$location" ]
then
    rsync "$backup_options" "$location" "$location/backup_$(date +"%Y-%m-%d_%H-%M-%S")" &> "backup_$(date +"%Y-%m-%d_%H-%M-%S").log"
    echo "Backup created: $location/backup_$(date +"%Y-%m-%d_%H-%M-%S")"
fi
