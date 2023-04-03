
# Dotfiles Backup and Restore

This is a Bash script for automatically backing up and restoring your dotfiles (configuration files) to and from a GitHub repository. The script allows you to easily transfer your configuration files to another computer or restore them if you need to reinstall your operating system.

## Prerequisites

Bash (version 4 or higher)
Git

## Usage

1. Download `dotback.sh` to your computer.
2. Open the script in a text editor.
3. Replace the list of files and directories in the `FILES_TO_BACKUP` array with the files and directories that you want to backup and restore.
4. Save the changes to the script.
5. Run the script in your terminal with the command `chmod +x dotback.sh && ./dotback.sh`.
When prompted, enter the URL of your GitHub repository for backing up and restoring your dotfiles.
6. Follow the menu options to backup or restore your dotfiles.

## Menu Options

The script provides the following menu options:

- Backup dotfiles: Creates a temporary directory, copies your dotfiles to the directory, commits and pushes the changes to your GitHub repository.
- Restore dotfiles: Creates a temporary directory, clones your GitHub repository to the directory, copies your dotfiles from the directory to your home directory.
- Exit: Exits the script.
