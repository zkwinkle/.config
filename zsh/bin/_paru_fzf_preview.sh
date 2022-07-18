#!/bin/zsh

# $1 = Q/S type of search
# $2 = program name

FULL_INFO=$(paru -"$1"i "$2")
DESCRIPTION=$(echo "$FULL_INFO" | rg '^Description' | sed 's/^Description.*: //m')
echo '\e[0;32m'"$DESCRIPTION"'\e[0m'
echo "$FULL_INFO"
