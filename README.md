# Linux Backup

This project is an automated backup system designed to securely compress, encrypt, and store backups both locally and in the cloud. It's written in Bash and utilizes 7-Zip for compression and rclone for cloud storage integration.

## Features

- Customizable backup paths and to-ignore paths
- Secure compression with 7-Zip and password protection
- Local and cloud storage of backups
- Automatic deletion of old backups (both local and cloud)
- Comprehensive logging system
- Pre-backup checks (file existence, permissions)
- Post-backup actions (ownership changes)

## Structure

The project is organized into several directories:

- `backups/`: Stores the compressed backup files
- `functions/`: Contains modular scripts for various functionalities
  - `cloud/`: Scripts for cloud operations
  - `compress/`: Compression logic
  - `post_backup/`: Post-backup actions
  - `pre_backup/`: Pre-backup checks
  - `utils/`: Utility functions (logging, timing, etc.)
- `main.sh`: The main script that orchestrates the backup process
- `paths-to-backup.txt`: List of paths to be backed up
- `paths-to-ignore.txt`: List of paths to be ignored during backup

## Usage

1. Configure the backup paths in `paths-to-backup.txt`
2. Set up ignore patterns in `paths-to-ignore.txt`
3. Configure cloud settings in `functions/config.sh`
4. Run the backup:

   ```bash
   ./main.sh
   ```

## Requirements

- Bash
- 7-Zip
- rclone (configured for your cloud provider)

## Configuration

Edit `functions/config.sh` to set:

- `BACKUP_PASSWORD`: Password for encrypting backups
- `RCLONE_REMOTE_NAME`: Your rclone remote name
- `RCLONE_REMOTE_BACKUP_FOLDER`: Remote folder for backups
- `RCLONE_MIN_AGE_TO_DELETE`: Minimum age of backups to delete from cloud


## rclone version:
```bash
❯ rclone --version
rclone v1.68.2
- os/version: raspbian 12.8 (64 bit)
- os/kernel: 6.6.62+rpt-rpi-v8 (aarch64)
- os/type: linux
- os/arch: arm64 (ARMv8 compatible)
- go/version: go1.23.3
- go/linking: static
- go/tags: none
```