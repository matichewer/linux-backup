#!/bin/bash


compress() {
    log DEBUG "Call compress $*"
    start_timer

    local paths_to_backup="$1"
    local paths_to_ignore="$2"
    local backup_file="$3"
    local BACKUP_PASSWORD="$4"

    log INFO "Compressing files with 7-Zip..."

    while IFS= read -r line
    do
        if [[ -z "$line" ]] || [[ "$line" == "#"* ]]; then
            continue
        fi
        
        7z a -mhe=on -m0=lzma2 -mx=3 -p"$BACKUP_PASSWORD" "$backup_file" "$line" -xr@"$paths_to_ignore" | log
        log INFO "Compressed ${line}"
    done < "$paths_to_backup"

    log TIME "Compression completed in $(end_timer)"  
}
