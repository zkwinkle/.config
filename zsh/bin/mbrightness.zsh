#!/bin/zsh

# Usage: ./mbrightness.zsh <inc|dec|+|-> <step> (0-100)

BUS=13 # Check i2c bus with 'ddcutil detect'
ACTION=$1
STEP=$2

CurrBright=$(ddcutil --bus $BUS getvcp 10 | grep -o 'current value = \+[0-9]\+' | awk '{print $4}')

case $ACTION in
	[iI][nN][cC] | +)
		NewBright=$((CurrBright + STEP))
		;;
	[dD][eE][cC] | -)
		NewBright=$((CurrBright - STEP))
		;;
	*)
		echo "Wrong usage: ./brightness.sh <inc|dec|+|-> <step>"
		exit 1
esac

# Clamp between 0 and 100
(( NewBright > 100 )) && NewBright=100
(( NewBright < 0 )) && NewBright=0

# Set brightness on external display
# Use brightnessctl first because it's faster and it works with polybar, but
# if it fails for whatever reason we default to ddcutil
if brightnessctl -d "ddcci${BUS}" set "$NewBright%" >/dev/null 2>&1; then
	echo "Monitor brightness set to $NewBright% using brightnessctl"
else
	ddcutil --bus $BUS --sleep-multiplier 0.1 setvcp 10 "$NewBright"
	echo "Monitor brightness set to $NewBright% using ddcutil"
fi
