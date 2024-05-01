#!/bin/bash

# DEFAULT VALUES
ICON="xclock"
NAME="Dunst Timer"

parse_time() {
	shopt -s nocasematch

	local input="$1"
	local hours=0
	local minutes=0
	local seconds=0

	while [[ $input =~ ([0-9]+)((h|hours?)|(m|mins?|minutes?)|(s|secs?|seconds?)) ]]; do
			case "${BASH_REMATCH[2]}" in
				h | hour | hours) hours=$(( hours + ${BASH_REMATCH[1]} )) ;;
				m | min | mins | minute | minutes) minutes=$(( minutes + ${BASH_REMATCH[1]} )) ;;
				s | sec | secs | second | seconds) seconds=$(( seconds + ${BASH_REMATCH[1]} )) ;;
			esac

		input="${input/${BASH_REMATCH[0]}}"
	done

	total_seconds=$(( hours * 3600 + minutes * 60 + seconds ))
	echo "$total_seconds"
}

formatTime() {
	if [[ $2 -eq 1 ]]; then
		printf '%02d' $(expr $1)
	else
		printf '%02d' $(expr $1 - 1)
	fi
}

timer() {
	MIN=$(expr $1 / 60)
	SEC=$(expr $1 - $MIN \* 60)

	for (( min=$MIN; min>=0; min-- ))
	do
		for (( sec=$SEC; sec>0; sec-- ))
		do
			BODY="$(formatTime $min 1):$(formatTime $sec)"
			OUTPUT=$(timeout 1 notify-send "$BODY" -r $2 -u low -a "$NAME" -i "$ICON" -A "Pause" -A "Stop" & sleep 1)
			case $OUTPUT in
				0)
					while [ 1 ]; do
						OUT=$(timeout 1 notify-send "Paused!" "$BODY" -r $2 -u critical -a "$NAME" -i "$ICON" -A "Resume" & sleep 1)
						if [[ $OUT = 0 ]]; then
							break
						fi
					done
					;;
				1)
					stop ;;
			esac
		done
		SEC=60
	done
	finish
}

start() {
	TIME=$1 # In seconds
	NOTI=$(notify-send "Timer Started!" -a $NAME -p)
	timer $TIME $NOTI
}

stop() {
	notify-send "Timer Cancelled" -a $NAME
	# If I want to do something on abort
	exit 0
}

finish() {
	notify-send "Timer Finished!" -u critical -a $NAME
	# If I want to do something when it fully finishes
	exit 0
}

trap stop SIGINT

if [[ $# -ne 1 ]]; then
	echo "Usage: timer [TIME]"
	exit 1
fi

parsed_seconds=$(parse_time "$1")
start $parsed_seconds
