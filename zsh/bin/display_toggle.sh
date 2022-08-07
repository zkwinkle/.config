#!/bin/sh

laptop=eDP-1-1
hdmi=HDMI-0

if xrandr | grep "$hdmi connected"; then
	if xrandr --listmonitors | grep "$laptop"; then
		xrandr --output "$laptop" --off --output "$hdmi" --auto
	else
		xrandr --output "$laptop" --auto --output "$hdmi" --auto --right-of "$laptop"
	fi
else
	xrandr --output "$laptop" --auto --output "$hdmi" --off
fi
