# Network Health Check Script

This is a bash script that checks the health of your network by performing the following tasks:

- Checks network connectivity by pinging Google.com
- Resolves DNS issues by checking if the nslookup command is installed, and installs it if necessary
- Resolves a user-specified domain name using nslookup to ensure DNS resolution is successful
- Verifies network configuration by checking if the ip addr show command works
- Tests internet speed using speedtest-cli and displays download and upload speeds
- Checks public IP address using curl and displays it

## Prerequisites

- ping command
- nslookup command (if not installed, it will be installed automatically)
- ip addr show command
- speedtest-cli command
- curl command

## How to Use

To use this script, simply run the following command:

1. Place the script in your desired directory.
2. Make the script executable with the following command: chmod +x net-diag.sh
3. Run the script with the following command: ./net-diag.sh
