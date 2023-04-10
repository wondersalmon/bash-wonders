# Bash Script for Sending Telegram Messages

This is a simple bash script that sends text messages through the Telegram API using a bot token and a chat ID. The script uses the curl command to make an HTTP POST request to the Telegram Bot API's sendMessage method.

## Usage

Before using this script, you need to provide your Telegram bot authentication token and chat ID. You can obtain a bot token from the BotFather and find your chat ID by messaging your bot and visiting https://api.telegram.org/bot<your-bot-token>/getUpdates in a web browser.

Once you have obtained your bot token and chat ID, you can use this script to send text messages:

1. Place the script in your desired directory.
2. Make the script executable with the following command: chmod +x telegram-notify.sh
3. Run the script with the following command: `./telegram-notify.sh "your message goes here"`
Make sure to replace `"your message goes here"` with the actual message you want to send.

If the message is successfully sent, you will not see any output in your terminal. However, if there is an error, you will see an error message printed in your terminal.

## Error Handling

If you do not provide a message to be sent, the script will print an error message and exit with status code 1.

If there is an error while sending the message, the script will print an error message and exit with a non-zero status code.

## Dependencies

This script requires the `curl` command to be installed on your system.