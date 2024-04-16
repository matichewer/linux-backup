#!/bin/bash


# Function to upload a file to cloud using rclone
# Usage: upload_to_cloud <source_file> <remote_name> <remote_backup_folder>
upload_to_cloud() {
    log DEBUG "Call upload_to_cloud $*"
    start_timer

    # Check if all parameters are provided
    if [ $# -ne 3 ]; then
        log ERROR "Usage: upload_to_cloud <source_file> <remote_name> <remote_backup_folder>"
        return 1
    fi

    # Assign parameters to variables
    source_file="$1"
    remote_name="$2"
    remote_backup_folder="$3"

    # Copy the file using rclone
    rclone copy "$source_file" "$remote_name":"$remote_backup_folder"
    
    # Check if the copy was successful
    if [ $? -eq 0 ]; then
        log TIME "Upload completed in $(end_timer)"
    else
        log CRITICAL "Failed to upload the file."
    fi

}

# Example usage:
# upload_to_cloud "$backup_file" "$RCLONE_REMOTE_NAME" "$RCLONE_REMOTE_BACKUP_FOLDER"
