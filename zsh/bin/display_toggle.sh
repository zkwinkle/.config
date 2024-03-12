#!/bin/sh

laptop=$(get_display.sh -l)
external=$(get_display.sh -e)
disconnected=$(get_display.sh -d)

# First, get the monitors and their horizontal resolutions
MONITORS=$(xrandr --current | grep '\bconnected' -A1 | awk '{printf "%s ", $1}' | sed 's/-- /\n/g' | sed 's/ \([0-9]\+\).*/ \1/')

HIGHEST_DIM=$(echo $MONITORS | sed 's/.*\s//' | sort -nr | head -1)

DPI=$(calc "96*$HIGHEST_DIM / 1920")
echo "dpi: $DPI"
dpi $DPI

# Takes monitor name as first input ($laptop or $external basically)
get_res() {
	monitor=$(echo "$MONITORS" | grep $1)
	dim=$(echo "$monitor" | awk '{print $2}')
	echo "$dim"
}

# Takes monitor name as first input ($laptop or $external basically)
get_scaling() {
	dim=$(get_res $1)

	scaling_factor=$(calc $HIGHEST_DIM / "$dim")
	echo "$scaling_factor"
}

if [ -n "$external" ]; then
	if xrandr --listmonitors | grep -q "$laptop"; then
		xrandr --output "$laptop" --off --output "$external" --scale 1x1 --auto
	else
		laptop_res=$(get_res $laptop)
		laptop_scaling_factor=$(get_scaling $laptop)
		external_scaling_factor=$(get_scaling $external)

		echo "scaling $laptop by $laptop_scaling_factor"
		echo "scaling $external by $external_scaling_factor"

		xrandr --output "$laptop" --scale "$laptop_scaling_factor"x"$laptop_scaling_factor" --auto --output "$external" --scale "$external_scaling_factor"x"$external_scaling_factor" --auto --pos $(calc "$laptop_res * $laptop_scaling_factor")x0
	fi
else
	xrandr --output "$laptop" --scale 1x1 --auto
	for MONITOR in $disconnected
	do
		xrandr --output "$MONITOR" --off
	done
fi

sleep 2
reload-polybar.sh
