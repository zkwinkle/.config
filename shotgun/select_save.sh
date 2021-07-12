#!/bin/sh -e

selection=$(hacksaw -f "-i %i -g %g")
timestamp=$(date --rfc-3339=s)
shotgun $selection "$HOME/Pictures/Screenshots/$timestamp"

