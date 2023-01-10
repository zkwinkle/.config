#!/bin/sh

# change i3lock img
IMG="$1"

# Need to convert to png with correct dimensions
RES=$(xrandr --current | grep -o 'current [0-9]\+ x [0-9]\+' | grep -o '[0-9]\+ x [0-9]\+')
HOR=${RES% x*}
VER=${RES#*x }

ffmpeg -y -i "$IMG" -vf scale=-1:"$VER",crop="$HOR":"$VER" "${ZDOTDIR}/i3lock.png" &> /dev/null

feh --bg-fill "$IMG"
