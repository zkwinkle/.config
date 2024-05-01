## Stuff used

- OS: Arch Linux
- WM: i3
- status bar: polybar
- Shell: zsh
- Terminal: kitty
- Cholor schemes: (flavours)[https://github.com/Misterio77/flavours] (read below)
- Text editor: Neovim
- Screenshots: shotgun + hacksaw
- rofi:
  - rofimoji
  - rofi-calc
- fetches:
  - neofetch
  - bunnyfetch
- preferred login manager: (lightdm-mini-greeter](https://github.com/prikhi/lightdm-mini-greeter] (needs lightdm, accountsservice, and some config)
- notifications: dunst
- fuzzy search: fzf
	- For preview: exa, bat, timg
- i3lock-multimonitor for locking on more than one screen (aliased to `i3lock`)
- optimus-manager to control discrete GPU (and it's conf in order to use nouveau in intel mode and access external monitors)

## Setup

### Random stuff

- python
- rustup (and then run `rustup default stable`)
- git
- networkmanager
- ripgrep
- fd
- xclip
- xdotool
- xsettingsd
- openssh
- keychain
- usbutils
- pulseaudio
- pulseaudio-bluetooth (for wireless headphones)
- ttf-jetbrains-mono
- nerd-fonts-jetbrains-mono
- jq (layout_manager dependency)
- htop
- ungoogled-chromium-bin
- ffmpeg
- man-db
- xorg-xbacklight
- bluez
- bluez-utils
- noto-fonts-cjk
- noto-fonts-emoji
- ttf-dejavu (polybar emoji)
- conda

#### Stuff i3 execs while starting up (remove from config or install)
- firefox
- thunderbird
- telegram-desktop
- discord
- spotify (last I installed the AUR package was broken, check AUR page for how to fix)
- feh

### zsh

Loot at zsh/example-zshenv and copy it to /etc/zsh/zshenv.

Also give executable permission to all the scripts:
```
chmod -R +x ~/.config/zsh/bin
chmod -R +x ~/.config/polybar/plugins
chmod -R +x ~/.config/dunst
```

### Weather

For the polybar weather plugin to work copy and paste the API key from
[OpenWeather](https://home.openweathermap.org/api_keys)
into `$HOME/.owm-key`.

In `weather/weather-plugin.sh` change CITYNAME and COUNTRYCODE if necessary.
Or leave empty for it to be based on IP (doesn't seem to work well :/ ).

### Cholor schemes (flavours)
I have a sane default color scheme, but to be able to switch to other pretty color schemes you need to install [flavours](https://github.com/Misterio77/flavours).
Then run:
```
flavours update all
```

#### Discord
Requires `discocss`.

#### Telegram
Requires `zip` and `convert` (ImageMagick).
To activate the theme, inside Telegram go to Settings > Chat Settings > Choose from file > ~/.config/telegram/base16.tdesktop-theme

#### Spotify
Requires installation of [spicetify](https://spicetify.app/). After installing run:
```
sudo chmod a+wr /opt/spotify
sudo chmod a+wrx /opt/spotify/Apps -R
spicetify backup apply
```

Then run:
```
spicetify config current_theme Ziro
spicetify config color_scheme base16
spicetify apply
```

In case spicetify theme breaks install the [community themes](https://github.com/spicetify/spicetify-themes) (`spicetify-themes-git` in the AUR). Then copy:
```
cp /usr/share/spicetify-cli/Themes/Ziro/user.css Themes/Ziro
cp /usr/share/spicetify-cli/Themes/Ziro/color.ini Themes/Ziro
```

and fix any incongruencies between `Themes/Ziro/color.ini` and `flavours/templates/spicetify/templates/Ziro.mustache`


#### Custom themes
I created a script called `theme` that lets you switch amongst some custom themes that automatically set the background and i3lock images.
To add a theme to this script edit `~/.config/zsh/.themes` and add your own themes.
The format of this file must be `<base16 scheme>:<wallpaper img>`.
So the theme must have the same name as a base16 scheme (that must be available
to `flavours apply <scheme>`) and the name of a wallpaper image that's inside
~/.config/wallpapers must be provided.

### Symlinks
```
ln -s ~/.config/.Xresources ~/.Xresources
ln -s ~/.config/.Xmodmap ~/.Xmodmap
ln -s ~/.config/optimus-manager.conf /etc/optimus-manager/optimus-manager.conf
mkdir -p ~/.themes
ln -s ~/.config/FlatColor ~/.themes/FlatColor
ln -s ~/.config/.gtkrc-2.0 ~/.gtkrc-2.0
```

### udev rules
Copy the necessary udev rules from udev into /etc/udev/rules.d
```
sudo cp ~/.config/udev/backlight.rules /etc/udev/rules.d/
```

### Groups
Add yourself to the necessary groups (this is for user `igna`):
```
sudo usermod -aG video igna
```

### DPI / Resolution / Scaling
In order for this system to work with displays with different resolutions and
DPIs, the following is done:

- Normally DPI is set to the default of 96
- If connecting an external display that has a larger resolution that 1920 then the DPI is set accordingly inside `display_toggle.sh`
- The screens that are a different res get xrandr scaling to look normal.
- You should restart apps to get them to adjust to new DPI.

### Framework Config
Because framework is HiDPI with a weird resolution, for simplicity to keep the
screen at 1920, add the following resolution mode inside `/etc/X11/xorg.conf.d/10-display.conf` for example.
```
Section "Monitor"
		Identifier "eDP-1"
		Modeline "1920x1280_60.00"  206.25  1920 2056 2256 2592  1280 1283 1293 1327 -hsync +vsync
		Option "PreferredMode" "1920x1280_60.00"
EndSection
```

#### Better sleep
Add the following kernel parameter in `/boot/loader/entries/XX.conf` in the `options` line:
- `mem_sleep_default=deep` ( Change suspend mode to suspend 2 RAM which is much more efficient )

#### Fix periodic freezes
Add the following kernel parameter in `/boot/loader/entries/XX.conf` in the `options` line:
- `i915.enable_psr=0` ( disable panel self refresh which causes periodic freezes )

Doing this will worsen battery life so only do it if necessary.


#### Brightness keys
Add file `/etc/modprobe.d/framework-als-deactivate.conf` with the following contents:
```
blacklist hid_sensor_hub
```
for brightness keys to be detected. This disables the light sensor.

#### Better thermals
[Reduce the fan noise](https://wiki.archlinux.org/title/Framework_Laptop#Lowering_Noise_of_Fans)

#### Touchpad config
This is my preferred config for the touchpad, write the following to a file in `/etc/X11/xorg.conf.d/30-touchpad.conf`:
```
Section "InputClass"
    Identifier "tap touchpad instead of hard regions"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lrm"
		Option "TappingDrag" "on"
		Option "TappingDragLock" "on"
		Option "ClickMethod" "clickfinger"
		Option "ClickMethod" "buttonareas"
		Option "ScrollMethod" "twofinger"
		Option "DisableWhileTyping" 1
EndSection
```

Requires installation of `libinput` ([docs](https://man.archlinux.org/man/libinput.4)).

### Hide untracked files
Beacause this repo isn't being symlinked into .config but is instead the .config itself:
```
git config --local status.showUntrackedFiles no
```

### Hide base16 edited files
Because you'll constantly have the colorscheme config files for each program show up in `git status` unless you tell git to ignore changes on these:
```
git update-index --skip-worktree i3/client-properties kitty/colors.conf nvim/lua/plugins/nvim-base16/colors.lua polybar/base16.ini polybar/dpi.ini polybar/plugins/weather-colors.sh rofi/theme.rasi rofi/dpi.rasi zathura/zathurarc FlatColor/colors2 FlatColor/colors3 discocss/custom.css flavours/common/colors.sh spicetify/Themes/Ziro/color.ini .Xresources dunst/dunstrc
```

## TODO

Stuff I'd like to add/upgrade but haven't had the time to:

- add cmp to nvim
- Rice Rofi

### Base16
- Fix discord theme a little for light-theme (white text inside little "Public" tag, possibly change text inside mentions)
- Make telegram scheme more light-theme friendly
- bat config
- somehow with firefox?? (thunderbird??? change to neomutt?)
- Add hooks for reloading everything neovim (impossible)
- Fix Spotify light theme (some icons don't change color)
- Fix discocss (fork that merges PRs?)

### Polybar
- Power (on/off/sleep/restart) menu
- I'd like to maybe fit in music info and a volume _bar_, but it won't fit nicely in my current main bar, would need to think of a different design ( widgets? )

### Dunst
- Add a notification sound
