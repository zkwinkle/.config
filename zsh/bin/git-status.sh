#!/bin/sh

# Best git prompt script to maybe take inspo:
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh

branch=""
action=""
if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ] 
then
	branch="%F{14}[$(git branch --show-current)] "
	# action="%F{14}(%a) "
fi
echo "$branch$action"
