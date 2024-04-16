#!/bin/bash


check_backup_dir() {
    log DEBUG "Call check_backup_dir $*"
    local backup_dir="$1"

    if [ ! -d "$backup_dir" ]; then
        log INFO "backup folder doesn't exist. Creating backup folder..."
        mkdir -p "$backup_dir"
        if [ $? -ne 0 ]; then
            log ERROR "I can't create the backup folder. Exiting..."
            exit 1
        fi
    fi
}