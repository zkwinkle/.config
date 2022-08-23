#!/bin/sh

if optimus-manager --print-mode | grep "integrated"; then
	laptop=eDP-1
	hdmi=HDMI-1-1
else
	laptop=eDP-1-1
	hdmi=HDMI-0
fi

if xrandr | grep "$hdmi connected"; then
	if xrandr --listmonitors | grep "$laptop"; then
		xrandr --output "$laptop" --off --output "$hdmi" --auto
	else
		xrandr --output "$laptop" --auto --output "$hdmi" --auto --right-of "$laptop"
	fi
else
	xrandr --output "$laptop" --auto --output "$hdmi" --off
fi
