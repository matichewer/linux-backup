#!/bin/bash


check_permission() {
    log DEBUG "Call check_permission $*"
    local paths_to_backup="$1"
    local current_user=$(whoami)
    local error_paths=() 
    while IFS= read -r line; do
        if [[ -z "$line" || "$line" == "#"* ]]; then
            continue
        fi
        local owner=$(stat -c '%U' "$line")
        if [[ "$owner" == "root" && "$current_user" != "root" ]]; then
            error_paths+=("$line")
        fi
    done < "$paths_to_backup"

    if [ ${#error_paths[@]} -gt 0 ]; then
        log ERROR "The following paths are owned by root and cannot be backed up without superuser permissions:"
        for error_path in "${error_paths[@]}"; do
            log ERROR "$error_path"
        done
        exit 1
    fi
}
