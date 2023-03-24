#!/bin/bash
#Setup config path
config_file=~/.ssh/config

# Check if ~/.ssh/config file exists
if [ ! -f $config_file ]; then
  echo "SSH config file not found. Aborting."
  exit 1
fi

# Set color and formatting escape sequences if tput is available
if command -v tput >/dev/null 2>&1; then
  bold=$(tput bold)
  normal=$(tput sgr0)
  red=$(tput setaf 1)
  green=$(tput setaf 2)
fi

# Get list of SSH servers from user's settings
servers=$(awk -F'[ =]+' '/^Host/{print $2}' $config_file)

# Print header
echo "${bold}Available SSH servers:${normal}"
# Print list of servers with numbers
i=1
for server in $servers; do
  ip=$(grep -A 1 "^Host $server$" $config_file | tail -n 1 | awk '{print $2}')
  if ping -c 1 -W 1 "$ip" >/dev/null 2>&1; then
    status="${bold}${green}UP${normal}"
  else
    status="${bold}${red}DOWN${normal}"
  fi
  printf "${i}) ${server} (${ip}) ${status}\n"
  i=$((i+1))
done

# Ask user to choose a server
read -p "${bold}Enter the number of the server to connect to: ${normal}" choice

# Connect to the chosen server
if [ $choice -le $i ] && [ $choice -gt 0 ]; then
  server=$(echo $servers | awk "{print \$$choice}")
  ip=$(grep -A 1 "^Host $server$" $config_file | tail -n 1 | awk '{print $2}')
  if ping -c 1 -W 1 "$ip" >/dev/null 2>&1; then
    printf "Connecting to ${bold}${green}${server} (${ip})${normal}\n"
    if command -v ssh >/dev/null 2>&1; then
      ssh $server
    else
      printf "${bold}${red}ssh command not found. Aborting.${normal}\n"
      exit 1
    fi
  else
    printf "${bold}${red}Server ${server} is not available.${normal}\n"
    exit 1
  fi
else
  printf "${bold}${red}Invalid choice.${normal}\n"
  exit 1
fi
