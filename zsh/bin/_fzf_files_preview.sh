#!/bin/zsh

#echo "$1"
echo '\e[0;32m'"$1"'\e[0m'
if [[ -e "$1" ]]
then
	if [[ -d "$1" ]]
	then
		exa --oneline --icons --sort=accessed "$1" | head -100
	elif [[ -f "$1" ]] 
	then
		MIMETYPE="$(file -b --mime-type - < "$1")"
		case "$MIMETYPE" in
			text/*) bat -n --color=always --wrap never --theme base16 --style=numbers "$1";;
			#image/*) kitty +kitten icat "$1" 1> /dev/null ;;
			image/*) echo "Image";;
			#application/pdf) $PDF_VIEWER "$1";;
			*) echo "Unsupported file type"
		esac
	else
		echo Uncategorized file type
	fi
fi
