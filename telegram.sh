#!/bin/bash

CHAT_ID="XXXXXX" # id чата куда отправляем. Можно узнать через @getmyid_bot \ #Specify the chat id. The bot @getmyid_bot will help you find out
TEXT="$1" 
BOT_AUTH_TOKEN="XXXXXXXXXXXXXXXXX" # Токен бота. Получаем после создания бота в @BotFather \ #Bot token. We get after creating the bot in @BotFather

# ПЕРЕД ЗАПУСКОМ СКРИПТА УБЕДИТЕСЬ ЧТО НАШЛИ СВОЕГО БОТА И НАЖАЛИ "ЗАПУСТИТЬ" \ #BEFORE LAUNCHING THE SCRIPT, MAKE SURE YOU HAVE FOUND YOUR BOT AND CLICKED "START"

# -s, --silent        Silent mode (тихий режим)
# -S, --show-error    Show error even when -s is used (показывать ошибки даже в тихом режиме)
# -i, --include       Include protocol response headers in the output (включить в вывод заголовки ответа)
#  -m, --max-time <time> Maximum time allowed for the transfer (Сколько времени ждать ответа)
# Передаем все данные в curl, которым сделаем запрос к API Telegram на отправку сообщения. \ # Pass all the data to curl, with which we will make a request to the Telegram API to send a message.
curl -sS -i --max-time 30 \
        --header 'Content-Type: application/json' \
        --request 'POST' \
        --data '{"chat_id": "'"${CHAT_ID}"'", "text": "'"${TEXT}"'"}' \
        "https://api.telegram.org/bot${BOT_AUTH_TOKEN}/sendMessage" 2>&1