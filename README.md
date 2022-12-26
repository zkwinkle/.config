## Stuff used

- OS: Arch Linux
- WM: i3-gaps
- status bar: i3status-rust
- Shell: zsh
- Terminal: kitty
- Cholor schemes: pywal (read below for reqs)
- Text editor: Neovim (nvim-packer-git for plugins)
- Screenshots: shotgun + hacksaw
- rofi:
  - rofimoji
  - rofi-calc
- fetches:
  - neofetch
  - bunnyfetch
- preferred login manager: lightdm-mini-greeter (needs lightdm, accountsservice, and some config)
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
- openssh
- keychain
- usbutils
- pulseaudio
- nerd-fonts-jetbrains-mono
- ttf-jetbrains-mono
- ttf-font-awesome-4
- noto-fonts-emoji
- alsa-utils (required by i3status-rust)
- jq (layout_manager dependency)
- htop
- ungoogled-chromium-bin
- ffmpeg
- man-db

#### Stuff i3 execs while starting up (remove from config or install)
firefox
thunderbird
telegram-desktop
discord
spotify
feh

### zsh

Loot at zsh/example-zshenv and copy it to /etc/zsh/zshenv.

Also give executable permission to all the scripts in /zsh/bin:
```
chmod +x ~/.config/zsh/bin
```


### Cholor schemes (pywal)
I have a sane default color scheme, but to use the pretty color schemes that match tbe bg you need to install [pywall](https://github.com/dylanaraps/pywal) (install direcly from git or the css template won't work), along with the following extensions for the differente applications:
- discord: [pywal-discord](https://github.com/FilipLitwora/pywal-discord) (+ betterdiscord and betterdiscordctl) 
- telegram: [telegram-palette-gen](https://github.com/agnipau/telegram-palette-gen) 
- [Thunderbird](https://addons.thunderbird.net/en-US/thunderbird/addon/pywalfox/) & [Firefox](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/): Pywalfox extension

#### Packages
- pywal-git
- python-pywalfox

### Disabling pywal
On `i3/config` comment line:
```
exec_always wal -R # restores last colorscheme
```
On `zsh/.zshrc` comment line:
```
(cat ~/.cache/wal/sequences &)
```
On `rofi/config.rasi` comment line:
```
@theme "~/.cache/wal/colors-rofi-light.rasi"
```

#### Considerations
Make sure to edit the variables in zsh/bin/pywal-env.sh to reflect the directories where you'll store wallpapers in your system, then for the current themes to work you must copy the /wal/wallpapers dir to $HOME/Pictures/Wallpapers (or whichever dir you choose).

The images which you use for your themes in switch-themes.sh can be backed up with backup-wallpapers.sh, just make sure to configure the right wallpaper dir.

You also need **ffmpeg** in order for the post-wal.sh script to work correctly and automatically set the image used by i3lock to match the wallpaper.

### Symlinks
```
ln -s ~/.config/.Xmodmap ~/.Xmodmap
ln -s ~/.cache/wal/colors.Xresources ~/.Xresources
ln -s ~/.config/optimus-manager.conf /etc/optimus-manager/optimus-manager.conf
```

### Hide untracked files
Beacause this repo isn't being symlinked into .config but is instead the .config itself:
```
git config --local status.showUntrackedFiles no
```
