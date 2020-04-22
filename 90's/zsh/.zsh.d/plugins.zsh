plugins=( \
  "/usr/share/fzf/completion.zsh" \
  "/usr/share/autojump/autojump.zsh" \
  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" \
  )

for plugin in "${plugins[@]}"; do
  if [[ -f $plugin ]]; then
    source $plugin
  fi
done

export FAST_HIGHLIGHT[use_bracket]=1
export FZF_DEFAULT_COMMAND='fd --type f -L'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
