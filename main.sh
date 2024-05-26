#!/bin/bash

# Paths to backup and ignore
paths_to_backup="paths-to-backup.txt"
paths_to_ignore="paths-to-ignore.txt"

# Name of the backup file
backup_dir="backups"
backup_file="${backup_dir}/backup_$(date +%Y-%m-%d_%H-%M-%S).7z"

# Load all functions
source functions/utils/load_functions.sh
load_functions

start_timer

# Pre checks
check_exists_files "$paths_to_backup" "$paths_to_ignore"
check_exists_paths "$paths_to_backup"
check_permission "$paths_to_backup"
check_backup_dir "$backup_dir"

# Compress the files
compress "$paths_to_backup" "$paths_to_ignore" "$backup_file" "$BACKUP_PASSWORD"

# Post compress
change_ownership "$backup_dir" "$backup_file"
delete_old_backups_from_local "$backup_dir"

# Cloud
upload_to_cloud "$backup_file" "$RCLONE_REMOTE_NAME" "$RCLONE_REMOTE_BACKUP_FOLDER"
delete_old_backups_from_cloud "$RCLONE_REMOTE_NAME" "$RCLONE_REMOTE_BACKUP_FOLDER" "$RCLONE_MIN_AGE_TO_DELETE"

log TIME "Total time elapsed: $(end_timer)"