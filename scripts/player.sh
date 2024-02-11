#!/bin/bash

# Fetch player status
status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    # Fetch player status icon
    status_icon=""  # Icon for playing state

    # Define icons for previous and next buttons
    prev_icon=""  # Icon for previous button
    next_icon=""  # Icon for next button
elif [ "$status" = "Paused" ]; then
    # Fetch player status icon
    status_icon=""  # Icon for paused state

    # Define icons for previous and next buttons
    prev_icon=""  # Icon for previous button
    next_icon=""  # Icon for next button
else
    # No song playing, output nothing
    exit 0
fi

# Output the icons and status
echo "$prev_icon $status_icon $next_icon"