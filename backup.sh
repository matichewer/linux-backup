#!/bin/bash


################################## COLOURS ###################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;93m'

BOLD='\e[1m'
NC='\033[0m' # No Color

GREEN_CHECK='\033[32m\u2713\033[0m'
RED_X='\033[31m\u2717\033[0m'

ERROR="${RED_X}${RED}[ERROR]${NC}"
INFO="${YELLOW}[INFO]${NC}"
OK="${GREEN_CHECK}${GREEN}[OK]${NC}"


################################ VARS ########################################

# Define the path of the .env file
env_file="paths-to-backup.txt"

# Name of the backup file
backup_file="backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"


############################## FUNCTIONS #####################################

check_files() {
    # Check if the .env file exists
    if [ ! -f "$env_file" ]; then
        echo -e "${ERROR} The .env file does not exist."
        exit 1
    fi
    
    # Check if backup file already exists
    if [[ -f "$backup_file" ]]; then
        echo -e "${ERROR} Backup file ${backup_file} already exists, skipping...${NC}"
        exit 1
    fi
    
    # Read each line of the .env file
    while IFS= read -r line
    do
        # Check if the line is empty or a comment
        if [[ -z "${line}" ]] || [[ "${line}" == "#"* ]]; then
            continue
        fi
        # Check if the path exists
        if [[ ! -d "${line}" ]] && [[ ! -f "${line}" ]]; then
            echo -e "${ERROR} Path '${line}' does not exist, stopping backup..."
            exit 1
        fi
    done < "$env_file"
    
    return 0
}

backup() {
    # Create an empty file for the backup
    touch "$backup_file"
    echo -e "${INFO} Backup file: $backup_file ${NC} \n"
    # Read the .env file again to add all existing paths to the backup
    while IFS= read -r line
    do
        # Check if the line is empty or a comment
        if [[ -z "$line" ]] || [[ "$line" == "#"* ]]; then
            continue
        fi
        
        # Add the path to the backup
        tar -rf ${backup_file} -P ${line} --exclude-from=paths-to-ignore.txt
        echo -e "${OK} Added '${line}'"
    done < "$env_file"
}


################################# MAIN #######################################
echo
if check_files; then
    backup
    echo -e "\n${BOLD} Backup completed successfully.${NC}"
else
    echo -e "${ERROR} An unexpected error occurred."
fi
