#!/bin/sh -e

window_id=$(xdotool getactivewindow)
timestamp=$(date --rfc-3339=s)
shotgun -i $window_id "$HOME/Pictures/Screenshots/$timestamp.png"

