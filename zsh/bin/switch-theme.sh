#!/bin/zsh
# Switches the pywal theme
# parameter is just one of the theme names given in the case statemente like "themeN)"

source pywal-env.sh

function help(){
	echo "Usage: $0 ["
}

alias wal="wal -o ${POSTWAL} -i"

case $1 in

	-h | --help | -help | --h | help)
		#TODO add help print and also put it under the default case
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
		wal "${WALLPAPERS}/Palace Grounds.jpeg" #mostly grey
		;;

	dark5)
		wal "${WALLPAPERS}/Salubra's Shop.jpeg" -b 110e16 # Purple ish
		;;

	dark6)
		wal "${WALLPAPERS}/Samurai Doge.png" -b 211b1a # p colorful
		;;
	
	dark7)
		wal "${WALLPAPERS}/Orange Sunset.jpg" -b 21120b # very orange
		;;
	

	# Light themes
	
	light1)
		wal "${WALLPAPERS}/Tiso on a Bench in Forgotten Crossroads.jpeg" -l --saturate 0.7
		;;

	light2)
		wal "${WALLPAPERS}/Samurai Doge.png" -l --saturate 0.6 # p colorful
		;;
	
	# Green themes??
	
	green1)
		wal "${WALLPAPERS}/Warrior at Lake Unn (without vignette).jpeg" -b 101613
		;;

	green2)
		wal "${WALLPAPERS}/Snoozing Knight on Bench at Queen's Garden.jpeg" -b 081316 # this one is more blueish
		;;
esac
