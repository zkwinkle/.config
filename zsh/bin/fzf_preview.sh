#!/bin/bash

echo "$1"
if [[ -e "$1" ]]
then
	if [[ -d "$1" ]]
	then
		echo Directory:
		exa --oneline --icons --sort=accessed "$1"
	elif [[ -f "$1" ]] 
	then
		if [[ $(file --mime "$1") =~ binary ]]
		then
			echo Binary file 
		else
			bat -n --color=always --wrap never --theme base16 --style=numbers "$1"
		fi
	else
		echo Uncategorized file type
	fi
fi
