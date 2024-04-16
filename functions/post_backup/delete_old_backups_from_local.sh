#!/bin/bash

delete_old_backups_from_local() {
    log DEBUG "Call delete_old_backups_from_local $@"
    local backup_dir="$1"
    find "$backup_dir" -type f -name "backup_*.7z" -mtime +30 -exec rm {} +
    log INFO "Backups older than 1 minute have been deleted."
}
