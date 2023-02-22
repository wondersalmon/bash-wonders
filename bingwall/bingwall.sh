#!/bin/bash

path="$HOME/Pictures/bing"
monitor="/backdrop/screen0/monitoreDP1/workspace0/last-image"

# Create the folder if it does not exist
if [ ! -d "$path" ]; then
    mkdir -p "$path"
fi

while true; do
    # Check internet connectivity
    if ping -q -c 1 -W 1 google.com >/dev/null; then
        # Get the current date and time
        current_time=$(date +"%Y-%m-%d_%H-%M-%S")
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
            # Check if the previous wallpaper was the same as the current one
            previous_wallpaper=$(xfconf-query -c xfce4-desktop -p $monitor -v | cut -d/ -f 5)
            if [ "$previous_wallpaper" != "$image_name" ]; then
                # Send a notification with the image title
                notify-send "Bing Wallpaper" "New wallpaper has been set: $image_title"
            fi
        fi
        # Remove any images older than the last 10 images
        ls -t | grep -v / | tail -n +11 | xargs -I {} rm -- {}
    else
        echo "No internet connection. Retrying in 20 seconds."
        sleep 20
        continue
    fi
    # Sleep for 1 hour
    sleep 3600
done
