## Stuff used

- OS: Arch Linux
- WM: i3-gaps
- Shell: zsh
- Terminal: kitty
- Cholor schemes: pywal
- Text editor: Neovim
- Screenshots: shotgun
- rofi: rofi
- fecthes:
	- neofetch
	- bunnyfetch


## Setup

### zsh

Loot at zsh/.example-zshenv and copy it to /etc/zsh/zshenv.

Also give executable permission to all the scripts in /zsh/bin:
```
chmod +x ~/.config/zsh/bin
```


### Cholor schemes
I have a sane default color scheme, but to use the pretty color schemes that match tbe bg you need to install [pywall](https://github.com/dylanaraps/pywal) (install direcly from git or the css template won't work), along with the following extensions for the differente applications:
- discord: [pywal-discord](https://github.com/FilipLitwora/pywal-discord) (+ betterdiscord and betterdiscordctl) 
- telegram: [telegram-palette-gen](https://github.com/agnipau/telegram-palette-gen) 
- [Thunderbird](https://addons.thunderbird.net/en-US/thunderbird/addon/pywalfox/) & [Firefox](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/): Pywalfox extension

Also make sure to copy the /wal/wallpapers dir to Pictures/Wallpapers (or whatever dir you use to store your wallpaper images, make sure to edit it in zsh/bin/switch-themes.sh).
Also to backup the images which you use for your themes in switch-themes.sh can be backed up with backup-wallpapers.sh, just make sure to configure the right wallpaper dir.
