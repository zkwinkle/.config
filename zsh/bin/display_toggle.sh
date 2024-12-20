#!/bin/sh

laptop=$(get_display.sh -l)
external=$(get_display.sh -e)
disconnected=$(get_display.sh -d)

# This script toggles a external monitor with the following logic:
#
#
# ## Which to turn on:
#
# - If external monitor not connected ( only laptop ), turn on laptop monitor
#   with --auto and turn off any others.
# - If external monitor connected:
#     - If laptop on, turn off laptop and turn on external monitor.
#     - If laptop off, turn on laptop and turn on external monitor.
#
# ## Scaling / DPI / resolution logic
#   - If -D is supplied and external monitor connected, adjust to external
#     monitor default resolution and DPI.
#   - Else, set DPI to the normal laptop's DPI.
#
#   - If -D not supplied and external monitor is connected, set external
#     monitor to resolution which matches laptop's default resolution.

# Conditions
LAPTOP_ON=$(xrandr --listmonitors | grep -q "$laptop"; echo $?)
EXTERNAL_CONNECTED=$([ -n "$external" ]; echo $?)
ADJUST_DPI=$([ "$1" = "-D" -o "$1" = "-d" ]; echo $?)

# Get the monitors and their default horizontal resolutions
MONITORS=$(xrandr --current | grep '\bconnected' -A1 | awk '{printf "%s ", $1}' | sed 's/-- /\n/g' | sed 's/ \([0-9]\+\).*/ \1/')

# Takes monitor name as first input ($laptop or $external)
get_default_horizontal_res() {
  monitor=$(echo "$MONITORS" | grep $1)
  dim=$(echo "$monitor" | awk '{print $2}')
  echo "$dim"
}

# Takes either $laptop or $external as parameter and returns a mode for the
# external monitor that can be used with xrandr's --mode flag.
#
# - If $1 = $laptop, gets the external monitor's xrandr mode that matches the
#   laptop's resolution.
# - If $1 = $external, gets the default external monitor's xrandr mode.
get_external_mode_that_matches() {
  horizontal_res=$(get_default_horizontal_res $1)
  # awk grabs the first mode it finds for the monitor with "res" horizontal
  # resolution
  xrandr --current | awk -v monitor=$external -v res=$horizontal_res '
    in_monitor && $0 ~ /^[^ ]/ {exit}
    in_monitor && $0 ~ res {print $1; exit}
    $0 ~ "^" monitor {in_monitor = 1}
  '
}

# Adjust DPI
if [ "$ADJUST_DPI" -eq 0 -a "$EXTERNAL_CONNECTED" -eq 0 ]; then
  DPI=$(calc "96*$(get_default_horizontal_res $external) / 1920")
else
  DPI="96"
fi
echo "dpi: $DPI"
dpi $DPI

# Turn on/off
if [ "$EXTERNAL_CONNECTED" -eq 0 ]; then

  LAPTOP_RES=$(get_default_horizontal_res $laptop)

  # Figure out external monitor resolution
  if [ "$ADJUST_DPI" -eq 0 ]; then
    MONITOR_RES=$(get_external_mode_that_matches $external)
  else
    MONITOR_RES=$(get_external_mode_that_matches $laptop)
  fi

  echo "monitor $external res = $MONITOR_RES"

  if [ "$LAPTOP_ON" -eq 0 ]; then
    xrandr --output "$laptop" --off --output "$external" --scale 1x1 --mode $MONITOR_RES

  else

    if [ "$ADJUST_DPI" -eq 0 ]; then
      LAPTOP_SCALING_FACTOR=$(calc "$MONITOR_RES" / "$LAPTOP_RES")
    else
      LAPTOP_SCALING_FACTOR="1"
    fi
    LAPTOP_SCALING="${LAPTOP_SCALING_FACTOR}x${LAPTOP_SCALING_FACTOR}"

    echo "scaling $laptop by $LAPTOP_SCALING"

    xrandr --output "$laptop" --scale "$LAPTOP_SCALING" --auto --output "$external" --scale 1x1 --mode $MONITOR_RES --pos $(calc "$LAPTOP_RES * $LAPTOP_SCALING_FACTOR")x0
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
