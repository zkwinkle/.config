#!/bin/sh

source pywal-env.sh

pywal-discord &
~/.telegram-palette-gen/telegram-palette-gen --wal &

# change i3lock img
IMG=$(cat "${HOME}/.cache/wal/last_used_theme" | grep -Eo "_.*${EXTENSIONS}" | sed "s/_/\//g" | sed "s/\(.*\)\//\1./")

# Need to convert to png with correct dimensions
RES=$(xrandr --current | grep -o 'current [0-9]\+ x [0-9]\+' | grep -o '[0-9]\+ x [0-9]\+')
HOR=${RES% x*}
VER=${RES#*x }

ffmpeg -y -i "${IMG}" -vf scale=-1:"$VER",crop="$HOR":"$VER" "${ZDOTDIR}/i3lock.png"
