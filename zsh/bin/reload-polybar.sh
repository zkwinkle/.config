#!/bin/sh

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
for m in $(polybar --list-monitors | cut -d":" -f1); do
    if [ "$m" = "DP-4" ] && [ -e /sys/class/backlight/ddcci13 ]; then
        MONITOR=$m BACKLIGHT=ddcci13 polybar 2>&1 | tee -a /tmp/polybar1.log & disown
    else
        MONITOR=$m polybar 2>&1 | tee -a /tmp/polybar1.log & disown
    fi
done

echo "Bars launched..."
