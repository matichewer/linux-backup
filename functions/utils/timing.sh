#!/bin/bash

# Function to start the timer
start_timer() {
    START_TIME=$(date +%s)
}

# Function to end the timer and calculate elapsed time
end_timer() {
    END_TIME=$(date +%s)
    ELAPSED_TIME=$((END_TIME - START_TIME))
    format_time $ELAPSED_TIME

}

# Function to format elapsed time in a human-readable format
format_time() {
    local total_seconds=$1
    local hours=$((total_seconds / 3600))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$((total_seconds % 60))

    local formatted_time=""
    if [ $hours -gt 0 ]; then
        formatted_time="${hours}h ${minutes}m ${seconds}s"
    elif [ $minutes -gt 0 ]; then
        formatted_time="${minutes}m ${seconds}s"
    else
        formatted_time="${seconds}s"
    fi

    echo "$formatted_time"
}

# Ejemplo de uso de las funciones
# start_timer
# sleep 5  
# end_timer