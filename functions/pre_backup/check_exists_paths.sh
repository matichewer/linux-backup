#!/bin/bash


check_exists_paths() {
    log DEBUG "Call check_exists_paths $*"
    local paths_to_backup="$1"
    local missing_paths=()

    while IFS= read -r line; do
        if [[ -z "${line}" ]] || [[ "${line}" == "#"* ]]; then
            continue
        fi
        if [[ ! -d "${line}" ]] && [[ ! -f "${line}" ]]; then
            missing_paths+=("$line") 
        fi
    done < "$paths_to_backup"

    if [ ${#missing_paths[@]} -gt 0 ]; then
        log ERROR "The following paths do not exist:"
        for missing_path in "${missing_paths[@]}"; do
            log ERROR "$missing_path"
        done
        exit 1
    fi
}
