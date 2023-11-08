## Source FNM (Fast Node Manager)
if (( ! $+commands[fnm] )); then
  return
fi

eval "$(fnm env --use-on-cd)"

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `fnm`. Otherwise, compinit will have already done that.
if [[ ! -f "$ZSH_CACHE_DIR/completions/_fnm" ]]; then
  typeset -g -A _comps
  autoload -Uz _fnm
  _comps[fnm]=_fnm
fi

fnm completions --shell=zsh >| "$ZSH_CACHE_DIR/completions/_fnm" &|
# Consider leveraging the following instead of FNM's provided zsh hook as it doesn't search parent directories for .nvmrc or .node-version files.
#
# __autoload-node-version() {
#   local _path=$PWD
#   local node_version_file
#
#   if [[ "${_path}" != *"/dev/"* ]]; then
#     return
#   fi
#
#   # Traverse parent directories until an nvmrc is encountered or root dev directory is encountered
#   while [[ "${_path}" != "" && "${_path}" == *"/home/\w+/dev/"* && (! -e "${_path}/.nvmrc" || ! -e "${_path}/.node-version") ]]; do
#     _path=${_path%/*}
#   done
#
#   # Check if .nvmrc file exists in the final directory from above.
#   if [ -e "${_path}/.nvmrc" ]; then
#     node_version_file="${_path}/.nvmrc"
#   fi
#
#   # Check if .node-verision file exists in the final directory from above.
#   if [ -e "${_path}/.node-version" ]; then
#     node_version_file="${_path}/.node-version"
#   fi
#
#   # Load appropriate NodeJS version
#   if [[ -n "${node_version_file}" ]]; then
#     fnm use --install-if-missing
#   elif [[ "$(fnm version)" != "$(fnm version default)" ]]; then
#     fnm use default
#   fi
# }

# autoload -U add-zsh-hook
# add-zsh-hook chpwd __autoload-node-version

