#!/bin/sh -e

window_id=$(xdotool getactivewindow)
shotgun -i $window_id - | xclip -t image/png -selection clipboard

