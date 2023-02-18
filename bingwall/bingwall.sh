#!/bin/bash

path="$HOME/Pictures/bing"
monitor="/backdrop/screen0/monitoreDP1/workspace0/last-image"

# Create the folder if it does not exist
if [ ! -d "$path" ]; then
    mkdir -p "$path"
fi

# Get the current date and time
current_time=$(date +"%Y-%m-%d_%H-%M-%S")

while true; do
    if nc -zw1 bing.com 443; then
        # Download the Bing image of the day and save it to the specified path
        image_url="http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)"
        image_title=$(echo $image_url | sed 's/.*OHR\.\(.*\)_ROW.*/\1/')
        image_extension=$(echo $image_url | sed 's/.*\.\(jpg\|jpeg\|png\|gif\)/\1/')
        image_name="$current_time-$image_title.$image_extension"
        cd $path
        # Check if the image has already been downloaded
        if [ ! -f "$path/$image_name" ]; then
            # Download the image and save it with the current date and time in the filename
            wget -O "$image_name" "$image_url"
            # Set the downloaded image as the desktop background
            xfconf-query -c xfce4-desktop -p $monitor -s "$path/$image_name"
            # Send a notification with the image title
            notify-send "Bing Wallpaper" "New wallpaper has been set: $image_title"
        fi
        # Remove any images older than the last 10 images
        ls -t | grep -v / | tail -n +11 | xargs -I {} rm -- {}
        sleep 10800 # Sleep for 3 hours
    else
        sleep 20
    fi
done
