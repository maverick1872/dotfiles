# Traverses PWD and up to find and autoload an nvmrc if exists. Compatible with lazy loading.
__autoload-nvmrc() {
  local _path=$PWD
  local nvmrc_path

  if [[ "${_path}" != *"/dev/"* ]]; then
    return
  fi

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
      nvm install
    elif [[ "${nvmrc_node_version}" != "$(nvm version)" ]]; then
      nvm use
    fi
  elif [[ "$(nvm version)" != "$(nvm version default)" ]]; then
    nvm use default
  fi
}

# autoload -U add-zsh-hook
# add-zsh-hook chpwd __autoload-nvmrc

