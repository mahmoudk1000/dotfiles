#!/usr/bin/env zsh
#
# - zshrc
#
# zsh configuration file


# sourcing
source $HOME/.plugins.zsh
source $HOME/.alias.zsh

# path changes
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export EDITOR=nvim
export BROWSER=firefox
export PATH=$HOME/src/sh/vem:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export MAKEFLAGS=' -j 8'

# Setting
autoload -U compinit
compinit
autoload -Uz promptinit; promptinit
eval "$(starship init zsh)"
setopt correctall
setopt autocd

_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# cd by typing dir name
setopt auto_cd
setopt autocd extendedglob nomatch notify

# keybinds
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^w' backward-kill-word
bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^r' history-incremental-search-backward
bindkey "^[[A"    history-substring-search-up
bindkey "^[[B"    history-substring-search-down
bindkey "^[[5~"	  beginning-of-line
bindkey "^A"	  beginning-of-line
bindkey "^[[6~"	  end-of-line
bindkey "^E"	  end-of-line
bindkey "^[[2~"   overwrite-mode
bindkey "^[[3~"	  delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Completion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

zmodload zsh/complist
setopt extendedglob
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

zstyle ':completion:*' menu select

# History
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY # using ":start:elapsed;command" format
setopt HIST_EXPIRE_DUPS_FIRST # remote duplicate when trimming history
setopt HIST_IGNORE_DUPS # ignore duplicated commands
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY # write immediately, not on shell exit
setopt SHARE_HISTORY # share command history data

# Custom Highlight syntax
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#3b4b58,underline"

# cmd not found msg
command_not_found_handler() {
	echo -e "nope, \e[31m'$0'\e[0m didn't work."; return 1
}
fpath=($fpath "/home/mahmoud/.zfunctions")

alias luamake=/home/mahmoud/Labby/lua-language-server/3rd/luamake/luamake
export PATH="$PATH:$HOME/.spicetify"
export PATH=$PATH:/home/mahmoud/.spicetify

##  Pista prompt
#autoload -Uz add-zsh-hook
#_pista_prompt() {
#	PROMPT="$(pista -z)"   # `pista -zm` for the miminal variant
#}
#add-zsh-hook precmd _pista_prompt

# prompt string to display, for regular users
#export PROMPT_CHAR="$"
#export PROMPT_CHAR_COLOR="magenta"

# prompt string to display, for the root user
#export PROMPT_CHAR_ROOT="#"
#export PROMPT_CHAR_ROOT_COLOR="red"

# symbol to represent clean repo state
#export GIT_CLEAN="·"
#export GIT_CLEAN_COLOR="blue"

# symbol to represent unstaged repo state
#export GIT_WT_MODIFIED="×"
#export GIT_WT_MODIFIED_COLOR="red"

# symbol to represent staged repo state
#export GIT_INDEX_MODIFIED="±"
#export GIT_INDEX_MODIFIED_COLOR="yellow"

# if HEAD ref peels to branch
#export BRANCH_COLOR="green"

# if HEAD ref peels to a commit (detached state)
#export COMMIT_COLOR="green"
