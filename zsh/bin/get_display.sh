#!/bin/sh

if optimus-manager --print-mode | grep "integrated" > /dev/null; then
	hdmi=HDMI-1-1
	laptop=eDP-1
else
	hdmi=HDMI-0
	laptop=eDP-1-1
fi

PROGRAM_NAME=get_display.sh

# Parse arguments
TEMP=$(getopt -n $PROGRAM_NAME -o lhLH \
	--long laptop,hdmi \
	-- "$@")

# Die if they fat finger arguments, this program will be run as root
#[ $? = 0 ] || $(echo "Error parsing arguments."; exit 1)

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
