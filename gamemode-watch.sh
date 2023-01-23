#!/bin/bash

# Check if gamemode is installed
if ! command -v gamemoded > /dev/null; then
    echo "Gamemode is not installed. Please install it from the following link: https://github.com/FeralInteractive/gamemode"
    exit 1
fi

while true
do
    gamemoded -s > /tmp/gamemode.txt
    state=$(cat /tmp/gamemode.txt)
    if [ ! -f /tmp/gamemode_prev.txt ]; then
        echo "$state" > /tmp/gamemode_prev.txt
    fi
    if [ "$state" != "$(cat /tmp/gamemode_prev.txt)" ]; then
        echo "$state" > /tmp/gamemode_prev.txt
        notify-send $state
    fi
    sleep 10
done
