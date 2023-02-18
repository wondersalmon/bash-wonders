# Bash-wonders

This project is a collection of 3 shell scripts that automate various tasks for Linux users.

## 1. backup-yd.sh

This script allows users to easily backup local folders to Yandex Disk, with the option to send notifications through Telegram using the `telegram.sh` script. The script uses `rsync` to copy the files and `tar` to archive them, and also includes a cleanup feature to free up disk space.

## 2. telegram.sh

This simple script is used for sending notifications of operations through Telegram. It can be used in conjunction with `backup-yd.sh`, but can also be used in other scripts to send notifications of any kind.

## 3. bingwall.sh

This script allows users to easily set the Bing Day Image as the XFCE4 desktop wallpaper. The script downloads the image and sets it as the wallpaper, and also allows the user to set the refresh rate of the wallpaper. No junk or big dependencies, fast and easy. Additional information in [bingwall.md](https://github.com/wondersalmon/bash-wonders/bingwall/bingwall.md)

## 4. net-diag.sh

The script is designed to perform network diagnostics. Upon execution, the script verifies the network settings to ensure proper connectivity. It then prompts the user to specify a website for network availability testing. Subsequently, the script performs an Internet speed test and records the output in a file named `speedtest.txt`. Finally, the script displays the public IP address of the network.

## Getting Started

To use these scripts, you will need to have the following installed on your Linux machine:

You will also need to have Yandex Disk and Telegram set up and configured on your machine.

## Usage

### backup-yd.sh

1. Edit the script and specify the path to the local folders you want to backup, and the path to the Yandex Disk folder where you want to make the backup.
2. Run the script: `sh backup-yd.sh`

Used dependencies:

- `rsync`
- `tar`
- `curl`
- `jq`
- `yandex-disk`
- `telegram`

### telegram.sh

1. Edit the script and specify your Chat ID and Bot Token.
2. Run the script with the message you want to send as an argument: `sh telegram.sh "Hello, this is a test message."`

### bingwall.sh

1. Run the script: `sh bingwall.sh`

### gamemode-watch.sh

The script monitors the [gamemode](https://github.com/FeralInteractive/gamemode) status and sends a notification. the loop is configured to check the state every 10 seconds, you can change this interval by specifying a different value in the `sleep` field (in seconds). Just add this script to autoload to make it work automatically

### net-diag.sh

Just `chmod+x net-diag.sh` and `./net-diag.sh`
