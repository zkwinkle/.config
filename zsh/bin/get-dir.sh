#!/bin/sh

dir="%B%F{blue}%3~"
if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]
then
	dir="%B%F{14}$(basename "$(git rev-parse --show-toplevel)")/$(git rev-parse --show-prefix)"
	dir=${dir%?} # Remove the last character (trailing /)
fi
echo $dir
