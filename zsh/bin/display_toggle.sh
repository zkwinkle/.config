#!/bin/sh -x

laptop=$(get_display.sh -l)
external=$(get_display.sh -e)
disconnected=$(get_display.sh -d)

if [ -n "$external" ]; then
	echo mik
	if xrandr --listmonitors | grep "$laptop"; then
		xrandr --output "$laptop" --off --output "$external" --auto
	else
		xrandr --output "$laptop" --auto --output "$external" --auto --right-of "$laptop"
	fi
else
	xrandr --output "$laptop" --auto
	for MONITOR in $disconnected
	do
		xrandr --output "$MONITOR" --off
	done
fi
