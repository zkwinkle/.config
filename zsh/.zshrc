# Apply pywal color scheme
(cat ~/.cache/wal/sequences &)

# use vi keybinds
bindkey -v

# Turn off bells caused by zsh
unsetopt BEEP

# ask for ssh password on prompt (only if logged in as user)
if [[ "$EUID" -ne 0 ]]
then
	eval "$(keychain --eval --quiet id_ed25519)"
fi

# Completion
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# History
HISTFILE=$ZDOTDIR/.histzsh
HISTSIZE=5000
SAVEHIST=50000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

export EDITOR='nvim'

# Quartus
export QSYS_ROOTDIR="/home/igna/.cache/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/21.1/quartus/sopc_builder/bin"


# Aliases
alias cls='clear'
alias i3lock='[ 1 -eq $(xrandr --listactivemonitors | head -1 | tail --bytes=2) ] && i3lock -i ${ZDOTDIR}/i3lock.png || i3lock-multimonitor -i ${ZDOTDIR}/i3lock.png' # lock using i3lock-multimonitor if multiple monitors connected
alias dragon='dragon-drag-and-drop'
alias ll='ls -lht' # ls with extra info ordered by time modified
alias git-tree='git ls-tree -r --name-only HEAD | tree --fromfile'
alias diff='diff -u'
alias dsf='diff-so-fancy'
# Get vid resolution
alias res='ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0'
alias see='kitty +kitten icat' # display image
function wTEC {
	sudo systemctl stop dhcpcd.service
	sudo systemctl start netctl.service
	sudo ip link set wlp6s0 down
	sudo netctl start wlp6s0-wTEC
}

# Path
PATH=${ZDOTDIR}/bin:$PATH
PATH=${PATH}:${HOME}/.local/bin
fpath=(${fpath} ${ZDOTDIR}/Completion) # Auto-completion

# Tab names
chpwd () {
	DIR=$(print -P "%~")
	print -n "\e]0;${${DIR%/}##*/}\a"
}

# vi mode config
export KEYTIMEOUT=1
vim_ins_mode=">"
vim_cmd_mode="<"
vindicator=$vim_ins_mode #variable that holds the vi mode indicator

function zle-keymap-select {
	vindicator="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
	zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init {
	vindicator=$vim_ins_mode
}

zle -N zle-line-init

# Prompt
setopt prompt_subst

# lambda to show privileges
lambda="%B%F{white}%(!.Λ.λ)"
# arrows
#arrows="%(!.%B%F{green}${vindicator}%F{cyan}${vindicator}%F{green}${vindicator}.%F{cyan}${vindicator}%F{magenta}${vindicator}%F{cyan}${vindicator})"
# Arrow colors (depend on privileges)
ac1="%B%(!.%F{green}.%F{cyan})"
ac2="%B%(!.%F{cyan}.%F{magenta})"

PROMPT='${lambda} $(git-status.sh)${ac1}${vindicator}${ac2}${vindicator}${ac1}${vindicator} %f%b'
RPROMPT='$(get-dir.sh)'

# FZF stuff
export FZF_DEFAULT_COMMAND='fd . --hidden -E .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd . ~ --type d --hidden -E .git'

export FZF_CTRL_T_OPTS='--preview="_fzf_files_preview.sh {}"'
export FZF_ALT_C_OPTS='--preview="_fzf_files_preview.sh {}" --preview-window=wrap'

  
export FZF_DEFAULT_OPTS='--height 60% --min-height 12 --reverse --border --multi --tiebreak="length,end" --info=inline --pointer="->" --marker="<>" --tabstop=2 
--color bg+:0,hl:2,hl+:2,prompt:6,pointer:6,fg+:6,marker:6,info:3,info:bold,hl+:underline,fg+:underline,hl:italic,spinner:2
--bind="ctrl-u:half-page-up,ctrl-d:half-page-down,change:first,ctrl-w:backward-kill-word,ctrl-b:backward-word,alt-bs:clear-query,ctrl-l:forward-char,ctrl-h:backward-char,ctrl-f:forward-word,alt-j:preview-down,alt-k:preview-up,alt-u:preview-half-page-up,alt-d:preview-half-page-down,ctrl-y:execute-silent(echo {} | xclip -sel clip)"'

# For ** paths
_fzf_compgen_path() {
  fd --hidden --exclude ".git" . "$1"
}

# Use fd to generate the list for directory ** completion
_fzf_compgen_dir() {
  fd --type d --hidden --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview="_fzf_files_preview.sh {}";;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" --preview-window=down;;
    *)            fzf "$@" ;;
  esac
}

alias fzf='fzf --preview="_fzf_files_preview.sh {}" --bind="ctrl-o:abort+execute(copen {})"'

## completion and keybinds

if [[ -f /usr/share/fzf/key-bindings.zsh && -f /usr/share/fzf/completion.zsh ]]
then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
else
	echo "Couldn't find fzf zsh files"
fi

# Open selections in nvim tabs
alias nviz='nvim -p "$(fzf)"'
alias fzh='fd . ~ --hidden -E .git | fzf'

# cd into a git repo
function fzg(){
	FIFO=/tmp/fzg_fifo;
	mkfifo $FIFO;
	(fd . ~ --type=d -E AUR -x check-for-git.sh > $FIFO &);
	_GIT_DIR=$(fzf --preview-window=wrap +m < $FIFO);
	[ -n "$_GIT_DIR" ] && cd "$_GIT_DIR" && nvim .
	rm $FIFO
}

# Install/Remove packages using paru/fzf
function pain(){
	paru -Slq | fzf -q "$1" -m --preview "_paru_fzf_preview.sh S {}" --preview-window=wrap | xargs -ro paru -S
}
function pare(){
	paru -Qq | fzf -q "$1" -m --preview "_paru_fzf_preview.sh Q {}" --preview-window=wrap | xargs -ro paru -Rns
}
