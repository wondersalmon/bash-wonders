#!/bin/bash

# Variables for storing paths to files and directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_DIR="/tmp"
GAMEMODE_FILE="$TMP_DIR/gamemode.txt"
GAMEMODE_PREV_FILE="$TMP_DIR/gamemode_prev.txt"

# Checking for permissions to files and directories
if [ ! -w "$TMP_DIR" ]; then
    echo "ERROR: You don't have write permission to $TMP_DIR directory."
    exit 1
fi

# Function to check if a command exists
function check_command {
    if ! command -v "$1" > /dev/null; then
        echo "ERROR: $1 command not found."
        exit 1
    fi
}

# Checking if the gamemoded command exists
check_command "gamemoded"

# Function for handling SIGINT and SIGTERM signals
function cleanup {
    rm -f "$GAMEMODE_FILE" "$GAMEMODE_PREV_FILE"
    exit
}
trap cleanup SIGINT SIGTERM

# Main script loop
while true
do
    # Getting the gamemoded state and writing it to a file
    gamemoded -s > "$GAMEMODE_FILE"

    # Reading state from a file
    state=$(cat "$GAMEMODE_FILE")

    # If the file with the previous state does not exist, create it and write the current state to it
    if [ ! -f "$GAMEMODE_PREV_FILE" ]; then
        echo "$state" > "$GAMEMODE_PREV_FILE"
    fi

    # If the current state differs from the previous one, we write it to a file with the previous state and display a notification
    if [ "$state" != "$(cat $GAMEMODE_PREV_FILE)" ]; then
        echo "$state" > "$GAMODE_PREV_FILE"
        notify-send "$state"
    fi

    # Pause before next loop iteration
    sleep 10
done
