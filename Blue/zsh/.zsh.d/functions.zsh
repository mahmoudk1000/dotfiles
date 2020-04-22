swap () {
  local TMPFILE=tmp.$$
  cp --reflink=auto -- "$1" "$TMPFILE"
  mv -- "$2" "$1"
  mv -- "$TMPFILE" "$2"
}


conf () {
  case $1 in
    vi|nvim) $EDITOR ~/.nvimrc ;;
    ncmpcpp) $EDITOR ~/.config/ncmpcpp/config ;;
    xrdb) $EDITOR ~/.Xresources ;;
    tmux) $EDITOR ~/.tmux.conf ;;
    zsh) $EDITOR ~/.zshrc ;;
    zsh-global) sudo -e /etc/zsh/zshrc ;;
    i3) $EDITOR ~/.config/i3/config ;;
    awesome) $EDITOR ~/.config/awesome/rc.lua ;;
    dwm) $EDITOR ~/src/c/dwm/config.h ;;
    dvtm) $EDITOR ~/src/c/dvtm/config.h ;;
    st) $EDITOR ~/src/c/st/config.h ;;
    polybar) $EDITOR ~/.config/polybar/config ;;
    *) echo "Mh, something goes wrong" ;;
  esac
}


src () {
  case $1 in
    zsh) source /etc/zsh/zshrc && sleep .5s && source $HOME/.zshrc ;;
    xrdb) xrdb -merge ~/.Xresources ;;
    dwm) pwd=$(pwd) && cd $HOME/src/c/dwm && makepkg -efi && cd $pwd ;;
    dvtm) pwd=$(pwd) && cd $HOME/src/c/dvtm && makepkg -efi && cd $pwd ;;
    st) pwd=$(pwd) && cd $HOME/src/c/st && makepkg -efi && cd $pwd ;;
    *) echo "Mh, something goes wrong" ;;
  esac
}

autogit () {
  git add -A && git ci -m "$1" && git push
}

ix () { [ -z "$1" -o -r "$1" ] && curl -F "f:1=<${1:--}" ix.io || printf '$ %s\n\n%s' "$*" "$("$@")" | ix ; }
sprunge () { [ -z "$1" -o -r "$1" ] && curl -F "sprunge=<${1:--}" http://sprunge.us || printf '$ %s\n\n%s' "$*" "$("$@")" | sprunge ; }
imgur () { [ -z "$1" -o -r "$1" ] &&  curl -s -F "image=<${1:--}" -F "key=486690f872c678126a2c09a9e196ce1b" https://imgur.com/api/upload.xml || printf '$ %s\n\n%s' "$*" "$("$@")" | imgur ; }
pbx () { curl -sF "c=@${1:--}" -w "%{redirect_url}" 'https://ptpb.pw/?r=1' -o /dev/stderr | xsel -l /dev/null -b }

npp () {
  if [ -n "$DISPLAY" ]; then
    #urxvtc -name ncmpcpp -cd $HOME -e ncmpcpp && exit
    termite --name=ncmpcpp -d $HOME -e ncmpcpp && exit
  else
    ncmpcpp
  fi
}


tmux_tty () {
  tmux \
    new -s tty -n "I" \; \
    neww -n "II" \; \
    neww -n "III" \; \
    neww -n "IV" \; \
    neww -n "V" \; \
    selectw -t "I" \;
  }

mk () {
  mkdir -p "$@" && cd "$@"
}

news () {
  #echo -e "\\e[01;31m\t\t >> News Archlinux.fr << \\e[00m\n$(curl -s https://archlinux.fr/feed | sed '/<title\|<pubDate/!d;s/\t*//g;s/<\/*title>/ - /g;s/[0-9]*:.*/\\e[00m/g;s/&#8217;/'"'"'/g;s/&#8211;/-/g;/Archlinux.fr/d' | sed 'N;s/\n<pubDate>/\\033[1;34m/g;P;D;')"

  read -r -d '' sed_trt <<EOF
  /<title\|<pubDate\|<rss /!d;
  s/\t*//g;
  /<rss /  {
  s/.*/\t\t\\\\e[31m>> News Archlinux.fr <<\\\\e[0m/
}
/<title>/  {
s,</*title>, - ,g
s/&#8217;/’/g
h
D
}
/<pubDate>/ {
s/^.\{14\}\(.\{11\}\).*$/\\\\e[34m\1\\\\e[0m/
H
g
s/\n//;
}
EOF
echo -e "$(curl -s https://archlinux.fr/feed | sed """$sed_trt""")"

}

maj () {
  repo="$(checkupdates 2> /dev/null | wc -l)"
  aur="$(cower -u 2> /dev/null | wc -l)"

  echo -e "MaJ : ${repo}, AUR : ${aur}"
}

dvtm-status () {
FIFO="/tmp/dvtm-status.$$"
[ -p "$FIFO" ] || mkfifo -m 600 "$FIFO" || exit 1

while true; do
  # wifi name
  test -n "$( iwgetid -r )" && WIFI="$( iwgetid -r ) | " || WIFI=""

    # song name
    test -n "$( mpc current )" && SONG="$( mpc current ) | " || SONG=""

    # volume
    VOL_STATUS=$( amixer get Master | grep '\[on\]' )
    if [ "${VOL_STATUS}" = "" ]; then
      VOL="mute"
    else
      VOL=$( amixer get Master | grep -E -o '[0-9]{1,3}?%' | head -1 )
    fi

    # date 'n time
    DATE=$( date +"%F %R" )

    echo -e "${SONG}${WIFI}${VOL} | ${DATE}"
    sleep 1s
  done 2> /dev/null > "$FIFO" &

  STATUS_PID=$!
  dvtm -s "$FIFO" 2> /dev/null
  kill $STATUS_PID
  rm -f "$FIFO"
}

omx () {
  regex='^(https?://)?(www\.)?(youtu(be\.(com|([a-z]{2}))|\.be)|nvimeo\.com|twitch\.tv)/[^ ]+$'
  #if printf '%s' "$1" | grep -Ee "${regex}"; then
    if grep -Ee "${regex}" <<< "$1"; then
      omxplayer -o local `youtube-dl -g -f 22/18/43/36/17 "$@"`
    else
      omxplayer -o local "$@"
    fi
  }

open () {
  nohup mimeopen "$@" &> /dev/null &
}

drun () {
  systemctl status docker &> /dev/null

  if [[ "$?" != "0" ]]; then
    echo "docker is not running"
    return 1
  else
    case "$1" in
      "kali"|"k"|"kalilinux")
        docker start 5553c075a2e7 > /dev/null && docker attach 5553c075a2e7
      	;;
      "mc"|"m"|"minecraft")
        echo "# TODO"
        echo "~/.zsh.d/functions:164"
        # docker run -d -p 25565:25565 --name mc itzg/minecraft-server
        ;;
      *)
      	echo "option not supported"
      	;;
    esac
  fi
}

# vim: ft=zsh:
