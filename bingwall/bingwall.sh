#!/bin/bash

# Constants
IMAGE_PATH="$HOME/Pictures/bing"
MONITOR="/backdrop/screen0/monitoreDP1/workspace0/last-image"
MAX_IMAGES=10
SLEEP_TIME=10400 ##in seconds
BING_IMAGE_URL="https://bing.com"

# Create the folder if it does not exist
if [ ! -d "$IMAGE_PATH" ]; then
    mkdir -p "$IMAGE_PATH"
fi

function check_internet_connectivity() {
    if curl -s --head https://www.google.com | head -n 1 | grep "HTTP/2.[200].." > /dev/null; then
        return 0
    else
        echo "No internet connection. Retrying in 20 seconds."
        sleep 20
        return 1
    fi
}

function download_bing_image() {
    local image_info=$(curl -s "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US")
    local image_url=$(echo "$image_info" | jq -r '.images[0].url' | sed 's/&pid=hp//')
    local image_title=$(echo "$image_info" | jq -r '.images[0].title')
    local image_extension=$(echo "$image_url" | sed 's/.*\.\([^.]*\)$/\1/')
    local image_name="$image_title.$image_extension"

    if [ ! -f "$IMAGE_PATH/$image_name" ]; then
        curl -s "https://www.bing.com$image_url" -o "$IMAGE_PATH/$image_name"
        if [ -f "$IMAGE_PATH/$image_name" ]; then
            xfconf-query -c xfce4-desktop -p $MONITOR -s "$IMAGE_PATH/$image_name"
            notify-send "New wallpaper has been set: $image_title"
            return 0
        else
            return 1
        fi
    fi
}

function remove_old_images() {
    local image_count=$(find "$IMAGE_PATH" -maxdepth 1 -type f | wc -l)
    if [ "$image_count" -gt "$MAX_IMAGES" ]; then
        local images_to_remove=$((image_count - MAX_IMAGES))
        find "$IMAGE_PATH" -maxdepth 1 -type f -printf '%T+ %p\n' | sort | head -n "$images_to_remove" | cut -d' ' -f2- | xargs -I {} rm -- {}
    fi
}

while true; do
    if check_internet_connectivity; then
        if download_bing_image; then
            remove_old_images
sleep $SLEEP_TIME
else
echo "Failed to download Bing image"
sleep 20
fi
else
echo "No internet connection. Retrying in 20 seconds."
sleep 20
fi
done