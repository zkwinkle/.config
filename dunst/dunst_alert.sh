#!/usr/bin/sh

SOUNDS="$XDG_CONFIG_HOME/dunst/alert_sounds"

play_sound() {
  if notification_already_present; then
    mpv "$SOUNDS"/portal_button_positive.m4a --volume=20 &
    return
  fi

  if [ "$DUNST_APP_NAME" = "Battery Notification" ]; then
    return
  fi

  if [ "$DUNST_APP_NAME" = "Dunst Timer" ]; then
    return
  fi

  if [ "$DUNST_APP_NAME" = "Spotify" ]; then
    return
  fi

  if [ "$DUNST_URGENCY" = "CRITICAL" ]; then
    mpv "$SOUNDS"/portal_button_positive.m4a --volume=80 &
  else
    mpv "$SOUNDS"/facebook_chat_pop.mp3 --volume=50 &
  fi

}

play_sound &> /dev/null
