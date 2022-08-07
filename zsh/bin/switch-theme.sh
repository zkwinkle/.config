#!/bin/zsh
# Switches the pywal theme
# parameter is just one of the theme names given in the case statemente like "themeN)"

source pywal-env.sh

function help(){
	echo "Help not implemented yet"
}

alias wal="wal -o ${POSTWAL} -i"

case $1 in

	-h | --help | -help | --h | help)
		#TODO add help print and also put it under the default case
		help
		;;

	# Dark themes
	dark1)
		wal "${WALLPAPERS}/Underbelly of the blue evening.jpeg" -b 1C1E26 #pink/blueish
		;;

	dark2)
		wal "${WALLPAPERS}/Entrance to Snail Shaman's Hut.jpeg" -b 17131e #purpleish
		;;

	dark3)
		wal "${WALLPAPERS}/Knight at edge of Dirtmouth.jpeg" -b 0c0d18 #blueish
		;;
	
	dark4)
		wal "${WALLPAPERS}/noellemonade night fair.png" --saturate 0.4 # pinkish
		;;

	dark5)
		wal "${WALLPAPERS}/SU sunny day.jpg" # colorful childish
		;;

	dark6)
		wal "${WALLPAPERS}/Samurai Doge.png" -b 211b1a # p colorful
		;;
	
	

	# Light themes
	
	light1)
		wal "${WALLPAPERS}/Underbelly of the blue evening.jpeg" -l
		;;

	light2)
		wal "${WALLPAPERS}/Train Station at City of Tears.jpeg" -l --saturate 0.5 # blue orange
		;;
	
	# Green themes??
	
	green1)
		wal "${WALLPAPERS}/Warrior at Lake Unn (without vignette).jpeg" -b 101613
		;;

	green2)
		wal "${WALLPAPERS}/Snoozing Knight on Bench at Queen's Garden.jpeg" -b 081316 # this one is more blueish
		;;
esac
