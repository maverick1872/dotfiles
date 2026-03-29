_require_commands "ripgrep.plugin.zsh" rg || return

export RIPGREP_CONFIG_DIR="$HOME/.config/ripgrep"
export RIPGREP_CONFIG_PATH="${RIPGREP_CONFIG_DIR}/config"

alias rg='rg --ignore-file=${RIPGREP_CONFIG_DIR}/ignore'

# Search and replace leveraging ripgrep
rg-sr() {
  rg $1 --hidden --files-with-matches | xargs -p sed -i'' -Ee "s|${1}|${2}|g"
}
