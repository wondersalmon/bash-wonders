#!/bin/bash

# Specify the chat id and bot token
CHAT_ID="XXXXXX"
BOT_AUTH_TOKEN="XXXXXXXXXXXXXXXXX"

# Get the text message to be sent as the first argument
MESSAGE="$1"

# Check if the message is empty
if [ -z "$MESSAGE" ]; then
    echo "Error: Please provide a message to be sent."
    exit 1
fi

# Send the message through Telegram API
curl -sS -i --max-time 30 \
        --header 'Content-Type: application/json' \
        --request 'POST' \
        --data '{"chat_id": "'"${CHAT_ID}"'", "text": "'"${MESSAGE}"'"}' \
        "https://api.telegram.org/bot${BOT_AUTH_TOKEN}/sendMessage" 2>&1
