_require_commands "restic.plugin.zsh" restic || return

export RESTIC_CONFIG_DIR="$HOME/.config/restic"

if (( ! $+commands[resticprofile] )); then
  _debug 'Resticprofile is not installed'
  return
fi

