#!/bin/sh

laptop=$(get_display.sh -l)
hdmi=$(get_display.sh -h)

if [ -n "$hdmi" ] && xrandr | grep "$hdmi connected"; then
	if xrandr --listmonitors | grep "$laptop"; then
		xrandr --output "$laptop" --off --output "$hdmi" --auto
	else
		xrandr --output "$laptop" --auto --output "$hdmi" --auto --right-of "$laptop"
	fi
else
	xrandr --output "$laptop" --auto --output "$hdmi" --off
fi
