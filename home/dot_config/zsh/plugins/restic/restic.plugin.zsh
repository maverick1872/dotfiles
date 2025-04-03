## If restic is not installed, don't load this plugin
if (( ! $+commands[restic] )); then
  _debug 'Restic is not installed'
  return
fi

export RESTIC_CONFIG_DIR="$HOME/.config/restic"

if (( ! $+commands[resticprofile] )); then
  _debug 'Resticprofile is not installed'
  return
fi

