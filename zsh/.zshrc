# use vi keybinds
bindkey -v

# ask for ssh password on prompt (only if logged in as user)
if [[ "$EUID" -ne 0 ]]
then
	eval $(keychain --eval --quiet id_ed25519)
fi

autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# History
HISTFILE=$ZDOTDIR/.histzsh
HISTSIZE=1000
SAVEHIST=5000

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

# Aliases
alias cls='clear'

# Git info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git # enable version control info only for git
zstyle ':vcs_info:git*' formats "%F{14}[%b] "
zstyle ':vcs_info:git*' actionformats "%F{14}[%b] (%a) "

precmd() { vcs_info }

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
arrows="%(!.%B%F{green}${vindicator}%F{cyan}${vindicator}%F{green}${vindicator}.%F{cyan}${vindicator}%F{magenta}${vindicator}%F{cyan}${vindicator})"
# Arrow colors (depend on privileges)
ac1="%B%(!.%F{green}.%F{cyan})"
ac2="%B%(!.%F{cyan}.%F{magenta})"

PROMPT='${lambda} ${vcs_info_msg_0_}${ac1}${vindicator}${ac2}${vindicator}${ac1}${vindicator} %f%b'
RPROMPT='$($ZDOTDIR/bin/get-dir.sh)'