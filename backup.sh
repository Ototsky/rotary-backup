#!/bin/bash


location="$1"
backup_options="-avb"
MAX_BACKUPS=3
log_file="$location/backup_ids.log"
if [ -f "$log_file" ]
then
    last_id=$(tail -n 1 "$log_file")
    next_id=$((last_id + 1))
else
    next_id=1
fi

if [ -d "$location" ]; then
    rsync "$backup_options" --exclude="backup_" "$location" "$location/backup_$next_id" &> "$location/backup_$next_id.log"
    echo "Backup created: $location/backup_$timestamp"
    echo "$next_id" >> "$log_file"

    if [ $(wc -l < "$log_file") -gt "$MAX_BACKUPS" ]; then
     oldest_id=$(head -n 1 "$log_file")
     rm -rf "$location/backup_$oldest_id"
     sed -i "1d" "$log_file"
    fi
fi






