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

# Lazily load NVM
__load_nvm() {
  if [[ -z "${NVM_LOADED}" ]]; then
    unset -f nvm node npm npx
    if [[ -s "${NVM_DIR}/nvm.sh" ]]; then
      . "${NVM_DIR}/nvm.sh"
      export NVM_LOADED="true"
    fi
  fi
}

## Source NVM if it is installed
# This only works if NVM is installed to the users home dir. Breaks for non-standard installs.
if [[ -d ${HOME}/.nvm ]] && [[ -f ${HOME}/.nvm/nvm.sh ]]; then
    export NVM_DIR="$HOME/.nvm"
    export PATH=$PATH:NVM_DIR

    # Load NVM completions
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  

    # nvm lazy loader wrapper
    function nvm() {
      __load_nvm
      nvm "$@"
    }

    function node() {
      __load_nvm
      node "$@"
    }

    function npm() {
      __load_nvm
      npm "$@"
    }

    function npx() {
      __load_nvm
      npx "$@"
    }

    autoload -U add-zsh-hook
    add-zsh-hook chpwd __autoload-nvmrc
fi

