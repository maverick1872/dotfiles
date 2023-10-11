# Traverses PWD and up to find and autoload an nvmrc if exists. Compatible with lazy loading.
__autoload-node-version() {
  local _path=$PWD
  local node_version_file

  if [[ "${_path}" != *"/dev/"* ]]; then
    return
  fi

  # Traverse parent directories until an nvmrc is encountered or root dev directory is encountered
  while [[ "${_path}" != "" && "${_path}" == *"/home/\w+/dev/"* && (! -e "${_path}/.nvmrc" || ! -e "${_path}/.node-version") ]]; do
    _path=${_path%/*}
  done

  # Check if .nvmrc file exists in the final directory from above.
  if [ -e "${_path}/.nvmrc" ]; then
    node_version_file="${_path}/.nvmrc"
  fi

  # Check if .node-verision file exists in the final directory from above.
  if [ -e "${_path}/.node-version" ]; then
    node_version_file="${_path}/.node-version"
  fi

  # Load appropriate NodeJS version
  if [[ -n "${node_version_file}" ]]; then
    fnm use --install-if-missing
  elif [[ "$(fnm version)" != "$(fnm version default)" ]]; then
    fnm use default
  fi
}

# autoload -U add-zsh-hook
# add-zsh-hook chpwd __autoload-node-version

