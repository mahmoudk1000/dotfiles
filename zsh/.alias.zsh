#!/usr/bin/env zsh
#
# - zshrc
#
# zsh configuration file


# Basic stuff
alias so="sudo"
alias l="ls"
alias ll="ls -lh"
alias la="ls -alh"

# Package Manager
alias pac="sudo pacman "
alias update="paru -Syu"
alias install="paru -S "
alias uninstall="paru -R "
alias purge="paru -Rcd "
alias gib="paru -Q "

# Text Editor
alias v="nvim"
alias svv="sudo nvim"

# Git
alias g="git"
alias glg="git log"
alias gl="git clone "
alias gs="git status"
alias gaa="git add --all"
alias gcp="git cherry-pick "
alias gcm="git commit -m "
alias gpl="git pull"
alias gp="git push"
alias gff="git diff"
alias free="free -h"

# St terminal
alias rel="xrdb merge /home/mahmoud/.Xresources && kill -USR1 $(pidof st)"

# Custom
alias mpp="mpd -v"
alias mm="ncmpcpp"
