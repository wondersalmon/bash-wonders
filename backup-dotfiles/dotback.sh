#!/bin/bash

# Set color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Ask the user for the repository to backup and restore their dotfiles
echo "Enter your GitHub dotfiles repository URL:"
read REPO_PATH

# Set the list of files and directories to backup and restore
FILES_TO_BACKUP=(
  ~/.zshrc
  ~/.zsh_history
  ~/nanorc
  ~/.ssh/config
)

# Show the menu
echo -e "${GREEN}Please select an option:${NC}"
echo "1. Backup dotfiles"
echo "2. Restore dotfiles"
echo "3. Exit"
read -p "Enter a number: " choice

# Handle the menu choice
case $choice in
  1)
    # Create a temporary directory for storing the files
TMP_DIR=$(mktemp -d)

# Clone the repository to the temporary directory
    echo "Cloning repository..."
    git clone $REPO_PATH $TMP_DIR

    # Copy the files to the temporary directory
    for file in "${FILES_TO_BACKUP[@]}"
    do
      if [ -f "$file" ] || [ -d "$file" ]; then
        cp -r "$file" "$TMP_DIR"
      else
        echo "$file not found, skipped."
      fi
    done

    # Commit and push the changes to the repository
    cd "$TMP_DIR"
    echo "Committing changes..."
    git add .
    git commit -m "Auto backup $(date +%Y-%m-%d)"
    git push origin main

    # Remove the temporary directory
    rm -rf "$TMP_DIR"

    echo -e "${GREEN}Backup completed successfully.${NC}"
    ;;
  2)
    # Create a temporary directory for storing the files
    TMP_DIR=$(mktemp -d)

    # Clone the repository to the temporary directory
    echo "Cloning repository..."
    git clone $REPO_PATH $TMP_DIR

    # Copy the files from the temporary directory to the home directory
    for file in "${FILES_TO_BACKUP[@]}"
    do
      if [ -f "$TMP_DIR/$(basename $file)" ] || [ -d "$TMP_DIR/$(basename $file)" ]; then
        cp -r "$TMP_DIR/$(basename $file)" "$(dirname $file)"
      else
        echo "$file not found in the repository, skipped."
      fi
    done

    # Remove the temporary directory
    rm -rf "$TMP_DIR"

    echo -e "${GREEN}Restore completed successfully.${NC}"
    ;;
  3)
    exit
    ;;
  *)
    echo -e "${RED}Invalid option.${NC}"
    ;;
esac
