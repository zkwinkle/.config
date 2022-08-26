#!/bin/sh


hdmi=$(xrandr --current | grep HDMI | awk '{print $1;}')
laptop=$(xrandr --current | grep eDP | awk '{print $1;}')

PROGRAM_NAME=get_display.sh

# Parse arguments
TEMP=$(getopt -n $PROGRAM_NAME -o lhLH \
	--long laptop,hdmi \
	-- "$@")

# Die if they fat finger arguments, this program will be run as root
[ $? = 0 ] || exit 1

eval set -- "$TEMP"
case $1 in
	-l|-L|--laptop)
		echo $laptop
		;;
	-h|-H|--hdmi)
		echo $hdmi
		;;
	*)
		printf "Unknown option %s\n" "$1"
		exit 1
		;;
esac
