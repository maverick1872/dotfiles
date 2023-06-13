# Traverses PWD and up to find and autoload an nvmrc if exists. Compatible with lazy loading.
__lazy-autoload-nvmrc() {
  local _path=$PWD
  local nvmrc_path

  # If NVM hasn't yet been loaded, load it so all later nvm commands work
  command __load_nvm

  # Traverse parent directories until an nvmrc is encountered or root dev directory is encountered
  while [[ "${_path}" != "" && "${_path}" == *"/home/\w+/dev/"* && ! -e "${_path}/.nvmrc" ]]; do
    _path=${_path%/*}
  done

  # Check if nvmrc exists in the final directory from above. Implementation replicates nvm_find_nvmrc
  if [ -e "${_path}/.nvmrc" ]; then
    nvmrc_path="${_path}/.nvmrc"
  fi

  # Load appropriate NVM version
  if [[ -n "${nvmrc_path}" ]]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [[ "${nvmrc_node_version}" = "N/A" ]]; then
      command nvm install
    elif [[ "${nvmrc_node_version}" != "$(nvm version)" ]]; then
      command nvm use
    fi
  elif [[ "$(nvm version)" != "$(nvm version default)" ]]; then
    command nvm use default
  fi
}

# Lazily load NVM
__load_nvm() {
  if [[ -z "${NVM_LOADED}" ]]; then
    unset -f nvm node npm
    if [[ -s "${NVM_DIR}/nvm.sh" ]]; then
      . "${NVM_DIR}/nvm.sh"
      export NVM_LOADED="true"
    fi
  fi
}

