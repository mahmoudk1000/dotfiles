[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

bindkey "^[[5~"	beginning-of-line
bindkey "^A"	beginning-of-line
bindkey "^[[6~"	end-of-line
bindkey "^E"	end-of-line
bindkey "^[[2~"	overwrite-mode
bindkey "^[[3~"	delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
