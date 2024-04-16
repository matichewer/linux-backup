#!/bin/bash

# Function to delete old backups from cloud using rclone
# Usage: delete_old_backups_from_cloud <remote_name> <remote_backup_folder> <min_age>
delete_old_backups_from_cloud() {
    log DEBUG "Call delete_old_backups_from_cloud $*"
    # Check if all parameters are provided
    if [ $# -ne 3 ]; then
        log ERROR "Usage: delete_old_backups_from_cloud <remote_name> <remote_backup_folder> <min_age>"
        return 1
    fi

    # Assign parameters to variables
    remote_name="$1"
    remote_backup_folder="$2"
    min_age="$3"

    # Delete old backups using rclone
    rclone delete "$remote_name":"$remote_backup_folder" --min-age "$min_age"
    
    # Check if the deletion was successful
    if [ $? -eq 0 ]; then
        log INFO "Old backups deleted successfully."
    else
        log ERROR "Failed to delete old backups."
    fi
}

# Example usage:
# delete_old_backups_from_cloud "$RCLONE_REMOTE_NAME" "$RCLONE_REMOTE_BACKUP_FOLDER" 7d
