#!/bin/bash

user=$USER
os=$(hostnamectl | awk '/Operating System/ {print $3 " " $4}')
shell="$(basename "$SHELL")"
kernel=$(uname -sr)
uptime=$(uptime -p | sed -e 's/up //; s/ hours/h/; s/ hour/h/; s/ minutes/m/; s/ minute/m/; s/,/ /')
#uptime="$(uptime -p | awk '/^up/ {print $2 " m"}')"
pkgs=$(pacman -Qq | wc -l)
wm=$(wmctrl -m | grep Name | sed 's/Name: //')
#wm="$(wmctrl -m | awk '/^Name:/ {print $2}')"
term=$(pstree -sA $$ | awk -F "---" '{ print $7 $2 }')
ram="$(free -m | awk '/^Mem:/ {print $3 "M / " $2 "M"}')"

echo -e "\n\e[1m\e[95m$user\e[97m@\e[95m$(hostname)\n\e[0m"
echo -e '\e[1m\e[93mos:\e[0m    '$os
#echo -e '\e[1m\e[93mkern:\e[0m  '$kernel
echo -e '\e[1m\e[93mup:\e[0m    '$uptime
echo -e '\e[1m\e[93msh:\e[0m    '$shell
echo -e '\e[1m\e[93mpkgs:\e[0m  '$pkgs
echo -e '\e[1m\e[93mwm:\e[0m    '$wm
echo -e '\e[1m\e[93mterm:\e[0m  '$term
echo -e '\e[1m\e[93mmem:\e[0m   '$ram

f=3 b=4
for j in f b; do
  for i in {0..7}; do
		printf -v $j$i %b "\e[${!j}${i}m"
  done
done
d=$'\e[1m'
t=$'\e[0m'
v=$'\e[7m'
 
cat << EOF

$f1██$d$t$f2██$d$f3██$d$f4██$d$f5██$d$f6██$d$f7██$d
EOF
echo -e "\e[0m"
