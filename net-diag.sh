#!/bin/bash

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check network connectivity
ping -c 1 google.com > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Network is up${NC}"
else
  echo -e "${RED}Network is down${NC}"
  exit 1
fi

# Resolve DNS issues
if ! command -v nslookup &> /dev/null; then
  if command -v pacman &> /dev/null; then
    echo -e "${YELLOW}nslookup command not found. Installing with pacman...${NC}"
    sudo pacman -S dnsutils --noconfirm
  elif command -v apt-get &> /dev/null; then
    echo -e "${YELLOW}nslookup command not found. Installing with apt-get...${NC}"
    sudo apt-get install dnsutils -y
    elif command -v yum &> /dev/null; then
    echo -e "${YELLOW}nslookup command not found. Installing with yum...${NC}"
    sudo yum install dnsutils -y
  elif command -v dnf &> /dev/null; then
    echo -e "${YELLOW}nslookup command not found. Installing with dnf...${NC}"
    sudo dnf install bind-utils -y
  else
    echo -e "${RED}Could not install nslookup. Please install it manually.${NC}"
    exit 1
  fi
fi

read -p "Enter a domain name to resolve: " domain
nslookup $domain > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo -e "${GREEN}DNS resolution for $domain is successful${NC}"
else
  echo -e "${RED}DNS resolution for $domain failed${NC}"
  exit 1
fi

# Verify network configuration
ip addr show > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Network configuration is correct${NC}"
else
  echo -e "${RED}Network configuration is incorrect${NC}"
  exit 1
fi

# Check internet speed
echo -e "${YELLOW}Testing internet speed...${NC}"
speedtest-cli --simple > speedtest.txt
if [ $? -eq 0 ]; then
  download=$(cat speedtest.txt | grep Download | awk '{print $2}')
  upload=$(cat speedtest.txt | grep Upload | awk '{print $2}')
  echo -e "Download speed: ${GREEN}$download${NC}"
  echo -e "Upload speed: ${GREEN}$upload${NC}"
else
  echo -e "${RED}Could not test internet speed${NC}"
fi

# Check public IP address
echo -e "${YELLOW}Checking public IP address...${NC}"
public_ip=$(curl -s https://api.ipify.org)
if [ $? -eq 0 ]; then
  echo -e "Public IP address is: ${GREEN}$public_ip${NC}"
else
  echo -e "${RED}Could not check public IP address${NC}"
fi