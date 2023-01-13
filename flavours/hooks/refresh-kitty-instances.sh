#!/bin/sh

for SOCKET in $(ls /tmp/kitty-*); do
	kitty @ --to "unix:${SOCKET}" --password="colors" set-colors ~/.config/kitty/colors.conf
done

