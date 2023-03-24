# SSH Server Selector Script

This Bash script allows you to easily select and connect to a SSH server from your settings file (~/.ssh/config), with the added bonus of showing the availability status of each server.

## Requirements

- Bash shell
- `ping` command
- `ssh` command
- (Optional) `tput` command for color and formatting output

## How to Use

1. Place the script in your desired directory.
2. Make the script executable with the following command: chmod +x ssh_server_selector.sh.
3. Run the script with the following command: ./ssh_server_selector.sh.
The script will list all available SSH servers in your settings file with their IP addresses and availability status (UP or DOWN).
4. Choose a server by entering the corresponding number.
The script will attempt to connect to the chosen server using the ssh command.

## Features

- Checks for the existence of the SSH settings file (~/.ssh/config) before executing.
- Displays a formatted list of available servers with their IP addresses and availability status.
- Checks the availability of each server using the ping command.
- Allows the user to select a server by entering its corresponding number.
- Connects to the chosen server using the ssh command.
- Shows an error message if the ssh command is not found.
- Shows an error message if an invalid choice is entered.

## Customization

This script can be easily customized to suit your needs. Here are some examples:

- Change the path of the SSH settings file by modifying the config_file variable.
- Change the color and formatting of the output by modifying the bold, normal, red, and green variables.
- Add more features, such as the ability to add or remove servers from the settings file.
