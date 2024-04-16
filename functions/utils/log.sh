#!/bin/bash

LOG_FILE="log_file.log"

COMMAND_OUTPUT="COMMAND_OUTPUT"
DEBUG="DEBUG"
INFO="INFO"
WARNING="WARNING"
ERROR="ERROR"
CRITICAL="CRITICAL"
TIME="TIME"

DEFAULT=$INFO


get_color(){
    local colour
    case "$1" in
        "$WARNING") colour="\e[33m" ;;           # Yellow
        "$INFO") colour="\e[32m" ;;              # Green
        "$ERROR") colour="\e[0;31m" ;;           # Light Red
        "$CRITICAL") colour="\e[1;31m" ;;        # Red
        "$COMMAND_OUTPUT") colour="\e[36m" ;;    # Cyan
        "$DEBUG") colour="\e[34m" ;;             # Blue
        "$TIME") colour="\e[35m" ;;              # Purple
        *) colour="\e[0m" ;;                     # No color (default)
    esac
    echo "$colour"
}

my_echo(){    
    echo -e "${2}$1\e[0m" # Concatenate the color code
    echo "$1" >> $LOG_FILE
}

save(){
    if [ $# -eq 1 ]; then # to print a command output
        my_echo "  $1"
    elif [ $# -eq 2 ]; then
        level="$1"
        message="$2"
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")    
        colour=$(get_color $level)
        
        to_print="[$timestamp][$level] $message"

        my_echo "$to_print" ${colour}
    fi
}

log_from_pipe(){
    level="$COMMAND_OUTPUT"
    message=$(history | tail -n 1 | sed -e 's/^[ ]*[0-9]\+[ ]*//')
    save "$level" "$message"
    while IFS= read -r line; do
        save "$line"
    done
    #message="FINISH"
    #save "$level" "$message"
}

log_from_param(){
    if [ -z "$2" ]; then
        level="$DEFAULT"
        message="$1"
    else
        level="$1"
        message=$2
    fi
    save "$level" "$message"
}

log(){
    if [ $# -eq 0 ]; then
        log_from_pipe
    else
        log_from_param "$1" "$2"
    fi
}


# Example usage
# log "This is a message without a log level, which is set to default as informational."

# log INFO "This is an informational message."
# log DEBUG "This is a debug message."
# log WARNING "This is a warning message."
# log ERROR "This is an error message."
# log CRITICAL "This is a critical message."

# ls -l | log
