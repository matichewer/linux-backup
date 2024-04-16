#!/bin/bash


BACKUP_PASSWORD=test

RCLONE_REMOTE_NAME=Mega_schwerdt.matias@gmail.com
RCLONE_REMOTE_BACKUP_FOLDER=/backups/notebook-exo-linux
RCLONE_MIN_AGE_TO_DELETE="7d"

# export rclone config to use if you execute the script with sudo
export RCLONE_CONFIG=/home/wecher/.config/rclone/rclone.conf

# for
set -o history