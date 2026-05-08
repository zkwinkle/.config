## Stuff used

- OS: Arch Linux
- WM: i3
- status bar: polybar
- Shell: zsh
- Terminal: kitty
- Cholor schemes: [flavours](https://github.com/Misterio77/flavours) (read below)
- Text editor: Neovim
- Screenshots: shotgun + hacksaw
- rofi:
  - rofimoji
  - rofi-calc
- fetches:
  - neofetch
  - bunnyfetch
- preferred login manager: [lightdm-mini-greeter](https://github.com/prikhi/lightdm-mini-greeter) (needs lightdm, accountsservice, and some config)
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
- tree-sitter-cli (auto install treesitter langs)
- keyd (key remaps)
- ddcutil (for external monitor brightness)
- tlp ([better battery life](https://wiki.archlinux.org/title/TLP))
- ghostmirror (mirror manager)
- delta (git diff tool)

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
Requires `vencord`.

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
ln -s ~/.config/keyd/default.conf /etc/keyd/default.conf
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
sudo usermod -aG video,keyd igna
```

### DPI / Resolution / Scaling
In order for this system to work with displays with different resolutions and
DPIs, the following is done:

- Normally DPI is set to the default of 96
- If connecting an external display that has a larger resolution that 1920 then the DPI is set accordingly inside `display_toggle.sh`
- The screens that are a different res get xrandr scaling to look normal.
- You should restart apps to get them to adjust to new DPI.

### Key mappings
I use `keyd` specifically for remapping stuff for WoW.

The rest is mapped inside Xmodmap, Win+Ctrl+l should set it. (see i3 config)

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
git update-index --skip-worktree i3/client-properties kitty/colors.conf nvim/lua/plugins/nvim-base16/colors.lua polybar/base16.ini polybar/dpi.ini polybar/plugins/weather-colors.sh rofi/theme.rasi rofi/dpi.rasi zathura/zathurarc FlatColor/colors2 FlatColor/colors3 Vencord/themes/DiscordRecolor.theme.css flavours/common/colors.sh spicetify/Themes/Ziro/color.ini .Xresources dunst/dunstrc
```

## TF2 workaround

TF2 is borked on Arch Linux, to get it working correctly do 2 things:

Note: I think this isn't necessary anymore since TF2 got a 64bit update. Remove if I ever test it out.

1. Install `lib32-gperftools` from AUR and set `LD_PRELOAD=/usr/lib32/libtcmalloc_minimal.so:$LD_PRELOAD %command% -novid -windowed` in the TF2 launch options.
2. Check the `Force the use of a specific Steam Play compatibility tool` option and set it to `Steam Linux Runtime 1.0 (scout)`.

## External monitor brightness

The [mbrightness](./zsh/bin/mbrightness.zsh) script can adjust the brightness
of an external monitor.

It requires the `ddcutil` program and for faster execution and polybar
compatibility one can install the `ddcci-driver-linux-dkms-git` driver.

It assumes the external monitor uses the i2c bus 13, which has held true for
my framework laptop when connecting monitors through HDMI in the same slot. But
if it breaks in the future this could be a likely cause.

As of June 2025 the ddcci driver is broken, it doesn't automatically create the
device. I tried using the last solution posted in
https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux/-/issues/7, with only
a udev rule. It sort of works but if I start my laptop with the HDMI already
connected it won't work. Get the same [device busy error as this
guy](https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux/-/issues/7#note_2562610485).

For now just manually executing

```sh
echo 'ddcci 0x37' | sudo tee /sys/bus/i2c/devices/i2c-13/new_device
```

will do.

## Better battery life TLP

Installing the `tlp` package can help improve battery life.

Instructions from [Arch Wiki page](https://wiki.archlinux.org/title/TLP):

```sh
sudo systemctl start tlp.service
sudo systemctl enable tlp.service
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
```

## Automatic mirror management

I use ghostmirror to automatically manage my Arch mirrors. Automatically periodically ranks them based on status, speed, up to date.

For setup need to run the following commands.

```sh
mkdir ~/.config/ghostmirror
ghostmirror -Po -c "United States,Canada,Mexico,Colombia,Chile" -l ~/.config/ghostmirror/mirrorlist -L 30 -S state,outofdate,morerecent,ping
ghostmirror -DPo -mul ~/.config/ghostmirror/mirrorlist ~/.config/ghostmirror/mirrorlist -s light -S state,outofdate,speed
```

Then edit file `/etc/pacman.conf`, search and replace this line and change <username> with your username.
```
[core]
Include = /home/<username>/.config/ghostmirror/mirrorlist

[extra]
Include = /home/<username>/.config/ghostmirror/mirrorlist
```

## Hibernation

In order to make hibernation on arch there's a few tweaks to be done.

1. Create a swapfile, see [arch wiki](https://wiki.archlinux.org/title/Swap#Swap_file_creation). I like a swapfile to not have to create a separate partition. Generally I don't use swap for the usual RAM depletion reason, so I need to set it up for hibernation.
2. In order to keep the swapfile small (I do 16GB) in the face of a bigger RAM (I have 64GB), we can [tweak the `image_size` variable](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#About_swap_partition/file_size) to make the hibernation image as small as possible. I set it to try to limit it to 2GB. To do this create `/etc/tmpfiles.d/hibernation_image_size.conf` with the following contents:

```
#    Path                   Mode UID  GID  Age Argument
w    /sys/power/image_size  -    -    -    -   2000000000
```

3. Add the `resume` hook to `/etc/mkinitcpio.conf`
Example:

```
HOOKS=(base udev autodetect keyboard keymap modconf block filesystems **resume** fsck)
```

Then regenerate initramfs: `sudo mkinitcpio -P`

### Laptop lid

To use `suspend-then-hibernate` when the laptop lid is closed, edit `/etc/systemd/logind.conf` and make sure `HandleLidSwitch` is set to `suspend-then-hibernate`. Beneficial to hibernate if I accidentally leave my system sleeping for too long.

```
HandleLidSwitch=suspend-then-hibernate
```

We like `suspend-then-hibernate` for this because if I (theoretically) run low on battery, or a set amount of time passes, the laptop goes into hibernation saving battery.

To set the amount of time the system waits to hibernate, we set [HibernateDelaySec](https://man.archlinux.org/man/systemd-sleep.conf.5) in `/etc/systemd/sleep.conf`.
The default is 2 hours, but I like setting it to 5 minutes.

```
HibernateDelaySec=300
```

### Low battery

Add the following to `/etc/udev/rules.d/99-lowbat.rules` in order to automatically hibernate when system is about to discharge:

```
# Suspend the system when battery level drops to 5% or lower
SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="/usr/bin/systemctl hybrid-sleep"
```

We use `hybrid-sleep` because if I connect the laptop before power runs out, waking up will be faster, but if battery runs out, system will be hibernated.

In order to enable low battery notifications, I've added the user systemd
service [./systemd/user/alert-battery.service] which automatically executes
[./dunst/low_battery_alert.sh] for low battery notifications.
Need to set the correct battery device in that script (BAT1 by default).
Enable it with:

```sh
systemctl --user enable alert-battery
```

#### graphical-session.target

(_Short section documenting this target_)

The low battery alert relies on the `graphical-session.target`, it's started by
i3 somewhere in the config because I couldn't figure out a more appropiate file
to put it in that would always run when starting a graphical session.

## TODO

Stuff I'd like to add/upgrade but haven't had the time to:

- Rice Rofi
- Use `eww` for a nicer status bar, power menu, timer

### Base16
- Make telegram scheme more light-theme friendly
- Look for a better spotify theme
