#!/bin/sh -e

timestamp=$(date --rfc-3339=s)
shotgun -s "$HOME/Pictures/Screenshots/$timestamp.png"

