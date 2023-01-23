#!/bin/bash

# Specify the path from where to get the files, and the path where you want to make a backup
source_path="path/to/source/folder" 
backup_path="path/to/yandex/folder" 

# Create a variable pointing to the script responsible for sending to telegram
telegram_script='./telegram.sh'

# Specify folders for backup if not all are needed
directories_to_backup="folder1 folder2 folder3"

# Create backup folder with current date
current_date=$(date +"%Y-%m-%d")
mkdir -p "$backup_path/$current_date"

# Starting the for loop, where for each value of the variable (the list in it) we do (do) a set of actions
for dir in $directories_to_backup; do
    echo "Copying $source_path/$dir to $backup_path/$current_date" 
    rsync -avh  "$source_path/$dir" "$backup_path/$current_date"
done

# We archive the entire folder in which the backup is located with gzip compression (-z)
tar -cvzf "$backup_path/backup_$current_date.tar.gz" "$backup_path/$current_date"

# Clean up to free up disk space
rm -rf "$backup_path/$current_date"

# Restarting the Yandex disk service (or insert a service from another file cloud here)
yandex-disk stop
yandex-disk start

# We send a message with the name of the backup in telegram. If we don't want it in telegram_script - change $telegram_script to echo
$telegram_script "backup_$current_date.tar.gz ready" >> /dev/null

# We get a list of backups from the folder in which they are stored.
backup_list=$(ls "$backup_path" | grep "backup_")

# Create a variable with the current month
current_month=$(date +"%m")

# Set the date when the backup will be considered obsolete.
expire_date=$(date +"%d" -d '-3 day')
echo "Deleting backups older than $(date +"%d.%m.%Y" -d '-3 day')"
for file in $backup_list; do
    # Get backup date
    backup_date=$(echo $file | awk -F"-" '{print $2}')

    echo "$file"

    if [[ $backup_date < $expire_date ]]
    then
        echo "Deleting a file  $file"
        rm -f "$backup_path/$file"
    fi