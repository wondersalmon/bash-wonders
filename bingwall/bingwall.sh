#!/bin/bash
#Checks if bing.com is available
while nc -zw1 bing.com 443; do
#Change this variable if you want to save the wallpaper to another location
path="$HOME/Pictures/bing"
#Define the monitor variable
monitor="/backdrop/screen0/monitor0/workspace0/last-image"
######### Don't change anything below this #########
# Create the folder if it does not exist
if [ ! -d "$path" ]; then
  mkdir -p "$path"
fi
cd $path
#Download the Bing image of the day and save it to the specified path
wget -O wallpaper.jpg "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)"
#Set the downloaded image as the desktop background
xfconf-query -c xfce4-desktop -p $monitor -s "$path/wallpaper.jpg"
break
done