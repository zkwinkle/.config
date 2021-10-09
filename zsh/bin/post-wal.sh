#!/bin/sh

source pywal-env.sh

pywal-discord &
~/.telegram-palette-gen/telegram-palette-gen --wal &

# change i3lock img
IMG=$(cat "${HOME}/.cache/wal/last_used_theme" | grep -Eo "_.*${EXTENSIONS}" | sed "s/_/\//g" | sed "s/\(.*\)\//\1./")
# Need to convert to png, specifically 1920x1080 dims for my screen
ffmpeg -y -i "${IMG}" -vf scale=1920:-1 "${ZDOTDIR}/i3lock.png"
