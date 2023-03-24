# Automatic Backup Script

This Bash script automates the backup process for specified folders from a source directory to a cloud storage location, such as Yandex disk. The script uses rsync to copy the selected folders, and archives them using gzip compression. Additionally, it sends a message via Telegram upon completion of each backup and deletes backups that are older than seven days.

## Prerequisites
rsync installed
Telegram account and bot set up for notifications (optional)
Yandex Disk set up and authenticated

## Usage

- Clone this repository to your local machine.
- Open the script file (backup_script.sh) in your preferred text editor.
- Modify the source_path, backup_path, and backup_dir variables to match your desired directories for source and backup.
- If using Telegram for notifications, set the telegram_script variable to the path of your telegram.sh script.
- Save and close the script file.
- Open a terminal window and navigate to the cloned repository directory.
- Run the script by entering ./backup_script.sh.

## Functionality

The script performs the following actions:

- Creates a backup folder with the current date.
- Copies selected folders from the source directory to the backup folder using rsync.
- Archives the backup folder using gzip compression.
- Deletes the backup folder to free up disk space.
- Stops and restarts the cloud storage service to ensure synchronization.
- Sends a message via Telegram (if configured) to confirm that the backup is complete.
- Deletes backups that are older than seven days.

## Customization

To select specific folders for backup, modify the `backup_dir` variable to list the desired folders.
To change the compression type, modify the `tar` command with the desired flag (e.g., tar -cvjf for bzip2 compression).
To change the expiration date for backups, modify the `expire_date` variable to reflect the desired time frame.
To skip Telegram notifications, change the `$telegram_script` variable to `echo`.