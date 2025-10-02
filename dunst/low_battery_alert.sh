#!/bin/sh

# Script runs permanently on a loop. Should maybe not do that?
#
# Started by systemd user file: [../systemd/user/alert-battery.service]

# Set to the correct battery device.
#
# Look at devices on /sys/class/power_supply/
# For example: /sys/class/power_supply/BAT1
BATTERY_DEVICE=BAT1

STATUS_FILE="/sys/class/power_supply/${BATTERY_DEVICE}/status"
CAPACITY_FILE="/sys/class/power_supply/${BATTERY_DEVICE}/capacity"

# $1 = current charge level (CAPACITY)
# $2 = whether to play a sound, we want to play a sound only on the first time
#      the notification shows up (so when the user first enters the low battery
#      state)
# $3 = the notification ID to use, we want to overwrite the same notification
#      because changing the app name causes them not to stack
send_notification() {
  NAME="Battery Notification"
  TITLE="⚠️🔌 Low Battery"
  BODY="Charge is at ${1}%"
  URGENCY="critical"


  STACK_TAG="battery-notification"

  if [ "$2" = "true" ]; then
    # We change the app name in order to trigger sound, since the "Battery
    # Notification" app name gets filtered out by ./dunst_alert.sh
    NAME="$NAME (different app name to trigger sound)"
  fi

  if [ -z "$3" ]; then
    notify-send "$TITLE" "$BODY" -a "$NAME" --hint=string:x-dunst-stack-tag:"$STACK_TAG" -p -u "$URGENCY"
  else
    notify-send "$TITLE" "$BODY" -a "$NAME" --hint=string:x-dunst-stack-tag:"$STACK_TAG" -p -u "$URGENCY" -r "$3"
  fi
}

while true; do
  STATUS=$(cat "$STATUS_FILE")
  CAPACITY=$(cat "$CAPACITY_FILE")

  if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -le 10 ]; then
    if [ -z "$FIRST_TIME" ]; then
      PLAY_SOUND="true"
      FIRST_TIME="done"
      NOTIFICATION_ID=
    else
      PLAY_SOUND=
    fi

    NOTIFICATION_ID=$(send_notification "$CAPACITY" "$PLAY_SOUND" "$NOTIFICATION_ID")

  else
    # Reset flag
    FIRST_TIME=
  fi

  sleep 10
done
