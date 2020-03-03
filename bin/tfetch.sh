#!/bin/bash

host=$(hostname)
os=$(hostnamectl | awk '/Operating System/ {print $3 " " $4}')
shell="$(basename "$SHELL")"
kernel=$(uname -sr)
uptime=$(uptime -p | sed -e 's/up //; s/ hours/h/; s/ hour/h/; s/ minutes/m/; s/ minute/m/; s/,//')
packages="$(pacman -Qq | wc -l)"
resolution="$(xrandr | awk '/*/ {print $1}')"
#resolution="$(xdpyinfo | awk '/dimensions:/ {print $2}')"
wm="$(wmctrl -m | awk '/^Name:/ {print $2}')"
terminal="$(xprop -id $WINDOWID WM_CLASS | cut -d" " -f3 | sed -e 's/^.\(.*\)..$/\1/; s/st-256color/st/')"
memory="$(free -m | awk '/^Mem:/ {print $3 "M / " $2 "M"}')"
mpd="$(ps aux | grep [m]pd | wc -l)"
spotify="$(ps aux | grep [s]potify | wc -l)"

if [ "$mpd" -ge 1 ]; then
	music="$(mpc current)"
elif [ "$spotify" -ge 1 ]; then
	music="$(python /home/ma/scripts/polybar/spotify_status.py -f '{artist} - {song}')"
else
	music=":("
fi


# COLORS

if [ -x "$(command -v tput)" ]; then
	bold="$(tput bold)"
	black="$(tput setaf 0)"
	red="$(tput setaf 1)"
	green="$(tput setaf 2)"
	yellow="$(tput setaf 3)"
	blue="$(tput setaf 4)"
	magenta="$(tput setaf 5)"
	cyan="$(tput setaf 6)"
	white="$(tput setaf 7)"
	grey="$(tput setaf 8)"
	reset="$(tput sgr0)"
fi

lc="${reset}${bold}${green}"        # labels
nc="${reset}${bold}${blue}"         # user and hostname


# OUTPUT

cat <<EOF

${nc}${USER}${reset}@${nc}${host}${reset}

${lc}os:    ${reset}${os}${reset}
${lc}up:    ${reset}${uptime}${reset}
${lc}pkgs:  ${reset}${packages}${reset}
${lc}sh:    ${reset}${shell}${reset}
${lc}res:   ${reset}${resolution}${reset}
${lc}wm:    ${reset}${wm}${reset}
${lc}term:  ${reset}${terminal}${reset}
${lc}mem:   ${reset}${memory}${reset}
${lc}np:    ${reset}${music}${reset}

${red}██${green}██${yellow}██${blue}██${magenta}██${cyan}██${white}██${reset}

EOF
