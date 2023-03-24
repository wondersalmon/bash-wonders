# Gamemode Monitor Script

This script is designed to monitor the state of Gamemode and display a notification when the state changes. Gamemode is a Linux daemon that allows games to request certain performance optimizations to the system, such as disabling the desktop compositor or changing the CPU governor. By monitoring the state of Gamemode, this script allows users to quickly and easily see whether their system is optimized for gaming.

## Prerequisites

Before running this script, you must have Gamemode installed on your system. 

## How to Use

To use this script, simply run the following command:

1. Place the script in your desired directory.
2. Make the script executable with the following command: chmod +x gamemode-watch.sh.
3. Run the script with the following command: ./gamemode-watch.sh..
The script will run indefinitely, monitoring the state of Gamemode every 10 seconds. If the state changes, a notification will be displayed indicating the new state.

To stop the script, press CTRL+C.

## Customization

This script can be customized to meet your specific needs by editing the following variables:

`TMP_DIR`: The directory where temporary files will be stored.
`GAMEMODE_FILE`: The filename of the file where the current Gamemode state will be stored.
`GAMEMODE_PREV_FILE`: The filename of the file where the previous Gamemode state will be stored.
The time between each check for Gamemode state (in seconds) can be changed by modifying the sleep command near the end of the script.