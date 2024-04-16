#!/bin/bash


# Function to recursively load files
load_functions() {
    # Directory containing function files and subdirectories
    FUNCTIONS_DIR="./functions"
    local dir="${1:-$FUNCTIONS_DIR}"

    for file in "$dir"/*; do
        if [ -d "$file" ]; then
            load_functions "$file"  # If it's a directory, load functions inside it
        elif [ -f "$file" ]; then
            source "$file"  # If it's a file, load the functions
        fi
    done
}
