
# Bing Wallpaper Changer for XFCE

A simple shell script to set Bing's picture of the day as your desktop wallpaper in XFCE.

## Dependencies

- wget

## Note

This script is written specifically for XFCE. If you use GNOME, there is an extension available [here](https://extensions.gnome.org/extension/1262/bing-wallpaper-changer/). Image of the Day support is built-in by default in KDE.

## Advantages

- Minimum dependencies
- Fast execution
- No unnecessary files generated

## Installation

- Download the script
- Make the script executable using the command in the terminal `chmod +x ./bingwall.sh`
- Run the script with the command `./bingwall.sh`

OR

- Do all these actions automatically with the command `curl https://raw.githubusercontent.com/wondersalmon/bash-wonders/main/bingwall/bingwall.sh >> bingwall.sh && chmod +x bingwall.sh && ./bingwall.sh`

The command will download the script, make it executable, and immediately run the script.

## Tuning

There are 2 variables in the script that can be changed:

- `path`: where to save the wallpaper
- `monitor`: a string indicating the monitor

If the wallpaper does not change on the first run, try running the command: `xfconf-query -c xfce4-desktop -p /backdrop -m` and then use the normal desktop settings to change the wallpaper. Check the result in the terminal and use the monitor value displayed in the terminal in place of the **$monitor** variable for the correct result.

## Scheduling

To make the script run automatically you can use the command `systemd-run --on-boot=180 --on-unit-active=14400 /path/to/folder/bingwall.sh`
You can specify your own values (in seconds)

*Enjoy your new Bing wallpaper!*
