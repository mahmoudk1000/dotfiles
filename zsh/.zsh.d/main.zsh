autoload -U compinit
compinit

zmodload zsh/complist
setopt extendedglob

setopt correctall
setopt autocd

autoload -U promptinit
promptinit

zmodload zsh/terminfo


if [[ $TERM == xterm-termite ]]; then
	. /etc/profile.d/vte.sh
	__vte_osc7
fi

# vim: ft=zsh:
