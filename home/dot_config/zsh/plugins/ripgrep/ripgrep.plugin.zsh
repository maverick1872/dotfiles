## If rg is not installed, don't load this plugin
if (( ! $+commands[rg] )); then
  _debug 'Ripgrep is not installed'
  return
fi

export RIPGREP_CONFIG_DIR="$HOME/.config/ripgrep"
export RIPGREP_CONFIG_PATH="${RIPGREP_CONFIG_DIR}/config"

alias rg='rg --ignore-file=${RIPGREP_CONFIG_DIR}/ignore'

# Search and replace leveraging ripgrep
rg-sr() {
  rg $1 --hidden --files-with-matches | xargs -p sed -Ee "s|${1}|${2}|g"
}
