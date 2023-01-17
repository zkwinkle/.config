#!/usr/bin/sh

DEST="${XDG_CONFIG_HOME}/telegram"

background_color="$(grep windowBg: ${DEST}/colors.tdesktop-theme | sed -r 's/.*(#.{6}).*/\1/')"
echo background color $background_color
mkdir -p "$DEST"
cd $DEST

convert -size 256x256 "xc:$background_color" tiled.jpg
zip -q base16.tdesktop-theme colors.tdesktop-theme tiled.jpg
