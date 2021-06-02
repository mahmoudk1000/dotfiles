# Basic stuff
alias so="sudo"
alias l="ls"
alias ll="ls -l"
alias la="ls -al"

# Package Manager
alias update="sudo xbps-install -Su"
alias install="sudo xbps-install "
alias uninstall="sudo xbps-remove "
alias purge="sudo xbps-remove -R "
alias gib="xbps-query "

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
alias gd="git diff"

# St terminal
alias load="kill -USR1 $(pidof st)"
alias use="xrdb merge"

# Custom
alias mpp="mpd -v"
alias mmm="ncmpcpp-ueberzug"
