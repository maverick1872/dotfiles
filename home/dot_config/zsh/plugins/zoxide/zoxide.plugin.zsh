if (( ! $+commands[zoxide] )); then
  _debug "zoxide is not installed"
  return
fi

eval "$(zoxide init --cmd cd zsh)"

