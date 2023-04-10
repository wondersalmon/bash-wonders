
# Bing Wallpaper Changer for XFCE

A simple shell script to set Bing's picture of the day as your desktop wallpaper in XFCE.

The script checks the availability of the bing site, and if the site is available, downloads the image of the day from the site and sets it as wallpaper on the XFCE4 desktop. If the site is not available, the script repeats the check every 20 seconds. The script is executed every 3 hours. to change this time edit the line `sleep 10800` (line 33) or delete it

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

## Tuning

There are some variables in the script that can be changed:

- `IMAGE_PATH`: where to save the wallpaper
- `MONITOR`: a string indicating the monitor
- `MAX_IMAGES` : the number of images to be saved
- `SLEEP_TIME` : interval for re-searching for new images in seconds
- `BING_IMAGE_URL`: Site url. I don't recommend changing it.

If the wallpaper does not change on the first run, try running the command: `xfconf-query -c xfce4-desktop -p /backdrop -m` and then use the normal desktop settings to change the wallpaper. Check the result in the terminal and use the monitor value displayed in the terminal in place of the **$monitor** variable for the correct result.

## Scheduling

Systemd and cron didn't work perfectly, so the easiest way to make the script run at autoload is to add it to the "Session and Startup". The correct command to run looks like this: `/usr/bin/bash "/path/to/script/bingwall.sh"`. Don't forget to replace path/to/script with your path, quotation marks are obligatory, trigger value - "on login".

*Enjoy your new Bing wallpaper!*
