# Bash-wonders

This project is a collection of shell scripts that automate various tasks for Linux users.

## 1. bingwall

This script allows users to easily set the Bing Day Image as the XFCE4 desktop wallpaper. The script downloads the image and sets it as the wallpaper, and also allows the user to set the refresh rate of the wallpaper. No junk or big dependencies, fast and easy. Additional information in [bingwall.md](https://github.com/wondersalmon/bash-wonders/blob/main/bingwall/Readme.md)

## 2. net-diag

The script is designed to perform network diagnostics. Upon execution, the script verifies the network settings to ensure proper connectivity. It then prompts the user to specify a website for network availability testing. Subsequently, the script performs an Internet speed test and records the output in a file named `speedtest.txt`. Finally, the script displays the public IP address of the network.

## 3. gamemode-watch

The script monitors the [gamemode](https://github.com/FeralInteractive/gamemode) status and sends a notification. the loop is configured to check the state every 10 seconds, you can change this interval by specifying a different value in the `sleep` field (in seconds). Just add this script to autoload to make it work automatically

## 4. sshmenu

This Bash script allows you to easily select and connect to a SSH server from your settings file `(~/.ssh/config)`, with the added bonus of showing the availability status of each server.

## 5. backup-dotfiles

A simple shell script for backing up and restoring your `dotfiles` (configuration files) using GitHub.

## Deprecated scripts

Outdated scripts that will be updated when I find time for them

### yandex-disk-backup

This script allows users to easily backup local folders to Yandex Disk, with the option to send notifications through Telegram using the `telegram.sh` script. The script uses `rsync` to copy the files and `tar` to archive them, and also includes a cleanup feature to free up disk space.

### telegram-notify

This simple script is used for sending notifications of operations through Telegram. It can be used in conjunction with `backup-yd.sh`, but can also be used in other scripts to send notifications of any kind.
