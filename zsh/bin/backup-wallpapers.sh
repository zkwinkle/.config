#!/bin/zsh

# Backs up the images used in switch-theme.sh from your WALLPAPERS folder in your system to .config/wal/wallpapers

# Set the extensions of the files you might want to backup
EXTENSIONS="(jpg|jpeg|png)"

WALLPAPERS="${HOME}/Pictures/Wallpapers"
wal_wallpapers="${XDG_CONFIG_HOME}/wal/wallpapers"


#Clear current ones
rm -f "${wal_wallpapers}/*"

#Copy into 
grep 'wal "${WALLPAPERS}/' "${ZDOTDIR}/bin/switch-theme.sh" | grep -Eo "/.*${EXTENSIONS}" | sed "s#^#\"${WALLPAPERS}#" | sed "s/$/\"/g" | xargs -I _ cp _ ${wal_wallpapers}/

