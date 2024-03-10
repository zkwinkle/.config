#!/bin/zsh

MON=$1 # Discover monitor name with: xrandr | grep " connected"
ACTION=$2
STEP=$3 # Step Up/Down brightnes by: 5 = ".05", 10 = ".10", etc.

STEP=$(bc <<< "scale = 2; ${STEP}/100")

CurrBright=$( xrandr --verbose --current | grep ^"$MON" -A5 | tail -n1 )
CurrBright="${CurrBright##* }"  # Get brightness level with decimal place

case $ACTION in
	[iI][nN][cC] | +)
		NewBright=$((CurrBright + STEP))
		;;
	[dD][eE][cC] | -)
		NewBright=$((CurrBright - STEP))
		;;
	*)
		echo Wrong usage of brightness.sh
		exit 1
esac

NewBright=$( [[ $NewBright -gt 1.0 ]] && echo 1.0 || echo $NewBright )
NewBright=$( [[ $NewBright -lt 0.0 ]] && echo 0.0 || echo $NewBright )

xrandr --output "$MON" --brightness $NewBright
