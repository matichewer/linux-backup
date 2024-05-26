#!/bin/bash

change_ownership() {
    log DEBUG "Call change_ownership $@"
    local backup_dir="$1"
    local backup_file="$2"

    local user=$(logname)
    chown "$user:$user" "$backup_dir"
    chown "$user:$user" "$backup_file"
    chown "$user:$user" log_file.log
}
