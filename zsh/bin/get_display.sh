#!/bin/sh

# Gives either the laptop or the first external connected monitor
laptop=$(xrandr --current | grep eDP | awk '{print $1;}')
disconnected=$(xrandr --current | grep disconnected | awk '{print $1;}')

# Try HDMI
external=$(xrandr --current | grep "HDMI[^ ]* connected" | head -1 | awk '{print $1;}')
if [ -n $external ]; then
	# Try Display Port
	external=$(xrandr --current | grep "^DP[^ ]* connected" | head -1 | awk '{print $1;}')
fi

case $1 in
	-l|-L|--laptop)
		echo "$laptop"
		;;
	-e|-E|--external)
		echo "$external"
		;;
	-d|-D|--disconnected)
		echo "$disconnected"
		;;
	*)
		printf "Unknown option %s\n" "$1"
		exit 1
		;;
esac
