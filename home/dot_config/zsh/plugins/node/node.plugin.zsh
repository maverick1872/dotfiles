_require_commands "node.plugin.zsh" node || return

# NODE & NPM
alias update-npm='npm install -g npm'
alias npmid='npm i -D'
alias npmip='npm i -P'

npmrc() {
  local cmd="${1}"
  local profile="${2}"

  case "$cmd" in
    list)
      _npmrc_list
      ;;
    activate)
      if [[ -z "$profile" ]]; then
        echo "Usage: npmrc activate <profile>" >&2
        return 1
      fi
      _npmrc_activate "$profile"
      ;;
    add)
      if [[ -z "$profile" ]]; then
        echo "Usage: npmrc add <profile>" >&2
        return 1
      fi
      _npmrc_add "$profile"
      ;;
    remove)
      if [[ -z "$profile" ]]; then
        echo "Usage: npmrc remove <profile>" >&2
        return 1
      fi
      _npmrc_remove "$profile"
      ;;
    *)
      echo "Usage: npmrc <list|activate|add|remove> [profile]" >&2
      return 1
      ;;
  esac
}

_npmrc_list() {
  local store="${NPM_CONFIG_USERCONFIG:h}"

  # Resolve the current active profile (if NPM_CONFIG_USERCONFIG is a symlink)
  local active=""
  if [[ -L "$NPM_CONFIG_USERCONFIG" ]]; then
    local target
    target="$(readlink "$NPM_CONFIG_USERCONFIG")"
    active="${target##*/}"    # basename
    active="${active%.profile}" # strip extension
  fi

  echo "Available npmrc profiles:"
  local found=0
  for f in "$store"/*.profile(N); do
    local name="${f##*/}"
    name="${name%.profile}"
    if [[ "$name" == "$active" ]]; then
      echo "  ✓ $name"
    else
      echo "  - $name"
    fi
    (( found++ ))
  done

  if (( found == 0 )); then
    echo "  You can create a profile with 'npmrc add'"
  fi
}

_npmrc_activate() {
  local name="$1"
  local store="${NPM_CONFIG_USERCONFIG:h}"
  local profile_path="$store/${name}.profile"

  if [[ ! -f "$profile_path" ]]; then
    echo "Profile not found: $profile_path" >&2
    echo "Available profiles:"
    _npmrc_list
    return 1
  fi

  # Guard: don't clobber a real (non-symlink) npmrc file
  if [[ -e "$NPM_CONFIG_USERCONFIG" && ! -L "$NPM_CONFIG_USERCONFIG" ]]; then
    echo "Error: $NPM_CONFIG_USERCONFIG is a regular file, not a symlink." >&2
    echo "Move or back it up before activating a profile:" >&2
    echo "  mv $NPM_CONFIG_USERCONFIG $store/<name>.profile" >&2
    return 1
  fi

  # Remove the existing symlink if present
  [[ -L "$NPM_CONFIG_USERCONFIG" ]] && rm "$NPM_CONFIG_USERCONFIG"

  ln -s "$profile_path" "$NPM_CONFIG_USERCONFIG"
  echo "Activated npmrc profile: $name"
}

_npmrc_add() {
  local name="$1"
  local store="${NPM_CONFIG_USERCONFIG:h}"
  local profile_path="$store/${name}.profile"

  if [[ -e "$profile_path" ]]; then
    echo "Profile already exists: $profile_path" >&2
    return 1
  fi

  echo "engine-strict=true" > "$profile_path"
  echo "Created npmrc profile: $name ($profile_path)"
  "${EDITOR:-vi}" "$profile_path"
}

_npmrc_remove() {
  local name="$1"
  local store="${NPM_CONFIG_USERCONFIG:h}"
  local profile_path="$store/${name}.profile"

  if [[ ! -f "$profile_path" ]]; then
    echo "Profile not found: $profile_path" >&2
    return 1
  fi

  # Guard: refuse to remove the currently active profile
  if [[ -L "$NPM_CONFIG_USERCONFIG" ]]; then
    local active
    active="$(readlink "$NPM_CONFIG_USERCONFIG")"
    if [[ "$active" == "$profile_path" ]]; then
      echo "Error: '$name' is the active profile. Activate another profile before removing it." >&2
      return 1
    fi
  fi

  read -q "REPLY?Remove npmrc profile '$name'? [y/N] "
  echo
  if [[ "$REPLY" != "y" ]]; then
    echo "Aborted."
    return 0
  fi

  rm "$profile_path"
  echo "Removed npmrc profile: $name"
}
