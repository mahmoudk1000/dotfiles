#!/bin/sh
# POLYWINS

# SETTINGS {{{ ---
active_text_color="#121212"
active_underline="true"
active_underline_color="#E7A09E"
inactive_text_color="#EEEEEE"
inactive_underline="false"
inactive_underline_color="#F1EF7D"
separator=" "
show="window_class" # options: window_title, window_class, window_classname
char_limit=20 # useful with window_title
char_case="lower" # options: normal, upper, lower
add_spaces="true"
resize_increment=30
wm_border_width=0 # setting this might be required for accurate resize position

# --- }}}



# Setup
actv_win_left="%{F$active_text_color}"
actv_win_right="%{F-}"
inactv_win_left="%{F$inactive_text_color}"
inactv_win_right="%{F-}"

if [ $active_underline = "true" ]; then
	actv_win_left="${actv_win_left}%{+u}%{u$active_underline_color}"
	actv_win_right="%{-u}${actv_win_right}"
fi

if [ $inactive_underline = "true" ]; then
	inactv_win_left="${inactv_win_left}%{+u}%{u$inactive_underline_color}"
	inactv_win_right="%{-u}${inactv_win_right}"
fi

active_workspace=$(wmctrl -d | awk '/\*/ {print $1}')
active_window=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print "0x0"substr($5,3)}')

# On-click actions
case "$1" in
raise_or_minimize)
	if [ "${active_window}" = "${2}" ]; then
		wmctrl -ir "$2" -b toggle,hidden
	else
		wmctrl -ia "$2"
	fi
	;;
close)
	wmctrl -ic "$2"
	;;
slop_resize)
	wmctrl -ia "$2"
	wmctrl -ir "$2" -e "$(slop -f 0,%x,%y,%w,%h)"
	;;
increment_size)
	wmctrl -ir "$2" -e "$(wmctrl -G -l |
		awk -v i="$resize_increment" \
		    -v b="$wm_border_width" \
		    -v win="$2" \
		'$1 ~ win {print "0,"$3-b*2-i/2","$4-b*2-i/2","$5+i","$6+i}')"
	;;
decrement_size)
	wmctrl -ir "$2" -e "$(wmctrl -G -l |
		awk -v i="$resize_increment" \
		    -v b="$wm_border_width" \
		    -v win="$2" \
		'$1 ~ win {print "0,"$3-b*2+i/2","$4-b*2+i/2","$5-i","$6-i}')"
	;;
esac

if [ -n "$2" ]; then exit; fi


# Generating the window list
window_list=$(wmctrl -lx | awk -vORS="" -vOFS="" \
	-v active_workspace="$active_workspace" \
	-v active_window="$active_window" \
	-v active_left="$actv_win_left" \
	-v active_right="$actv_win_right" \
	-v inactive_left="$inactv_win_left" \
	-v inactive_right="$inactv_win_right" \
	-v separator="$separator" \
	-v show="$show" \
	-v c_case="$char_case" \
	-v char_limit="$char_limit" \
	-v add_spaces="$add_spaces" \
	-v on_click="$0" \
	'{
	if ($2 != active_workspace && $2 != "-1") { next }
	if ($3 ~ "polybar" || $3 ~ "yad") { next }

	if (show == "window_class") {
		lastitem=split($3,classname_and_class,".")
		displayed_name = classname_and_class[lastitem]
	}
	else if (show == "window_classname") {
		split($3,classname_and_class,".")
		displayed_name = classname_and_class[1]
	}
	else if (show == "window_title") {
		# format window title from wmctrl output
		title = ""
		for (i = 5; i <= NF; i++) {
			title = title $i
			if (i != NF) { title = title " "}
		}
		displayed_name = title
	}

	if      (c_case == "lower") { displayed_name = tolower(displayed_name) }
	else if (c_case == "upper") { displayed_name = toupper(displayed_name) }

	if (length(displayed_name) > char_limit) {
		displayed_name = substr(displayed_name,1,char_limit)"…"
	}

	if (add_spaces == "true") { displayed_name = " "displayed_name" " }

	if ($1 == active_window) {
		displayed_name=active_left displayed_name active_right
	}
	else {
		displayed_name=inactive_left displayed_name inactive_right
	}

	if (non_first == "") { non_first = "true" } else {
		print separator # only on non-first items
	}

	print "%{A1:"on_click" raise_or_minimize "$1":}"
	print "%{A2:"on_click" close "$1":}"
	print "%{A3:"on_click" slop_resize "$1":}"
	print "%{A4:"on_click" increment_size "$1":}"
	print "%{A5:"on_click" decrement_size "$1":}"
	print displayed_name
	print "%{A}%{A}%{A}%{A}%{A}"
	}')

echo "$window_list"
