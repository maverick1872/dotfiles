unset -f git_develop_branch
unset -f git_main_branch
git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  
  mainBranchName=$(command git config --local user.mainBranchName)
  command git show-ref -q --verify "refs/heads/$mainBranchName" && echo "$mainBranchName" && return

  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{master,main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo "No main branch found. Set git local config 'user.mainBranchName' to specify a non traditional branch" >&2
  return 1
}

git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return

  devBranchName=$(command git config user.developBranchName)
  command git show-ref -q --verify "refs/heads/$devBranchName" && echo "$devBranchName" && return

  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo "No develop branch found. Set git local config 'user.developBranchName' to specify a non traditional branch" >&2
  return 1
}

# Checkout Github PR
gcopr() {
  gh pr checkout "$1"
}

# View Github PR
viewpr() {
  gh pr view "$1" --web
}

# Find process running on specified port
show-port() {
  lsof -P -n -i :"$1"
}

dco() {
# Can be improved with a proper jq function? https://stackoverflow.com/questions/62665537/how-to-calculate-time-duration-from-two-date-time-values-using-jq
  if [[ $1 == "ps" ]]; then
    command docker compose ps --format json | \
	    jq -r '[{"Name": "Container Name", "Service": "Service Name", "Status": "Status", "Created": "Created"}, .[]] | .[] | [.Name, .Service, .Status, (.Created | if type=="number" then (.|strflocaltime("%Y-%m-%dT%H:%M:%S")) else . end)] | @tsv' | \
      column -ts $'\t'
    return
  fi;

  command docker compose "$@"
}

# Traverses directory structure and updates all docker images
update-docker-containers() {
  for dir in $(find ${DOCKER_DIR} -maxdepth 1 -mindepth 1 -type d); do
    containerName=$(basename $dir)
    cd $dir || return
    if [[ `docker-compose ps -q 2> /dev/null` ]]; then
      echo "Updating container: $containerName"
      docker-compose pull && docker-compose up --force-recreate --build -d
      cd - > /dev/null || return
    else
      echo "Container is not running: $containerName"
    fi
    echo
  done    
}                                                              

## Update all things shell related
update-shell() {
  omz update && update-zsh-customizations && update-zsh-plugins
}

# Short-hand to grep all aliases available
search-aliases() {
  alias | grep "$1" --color
}

# Short-hand for search and replace leveraging ripgrep
rg-sr() {
  rg $1 --files-with-matches | xargs -p sed -i '' "s|${1}|${2}|g"
}

# List IPs of all running docker containers for each network they are attached to
docker-ips() {
  docker ps --format "table {{.ID}}|{{.Names}}|{{.Status}}" | while read line; do
    if $(echo $line | grep -q 'CONTAINER ID'); then
      output="${line}|IP ADDRESSES\n"
    else
      CID=$(echo $line | awk -F '|' '{print $1}')
      IP=$(docker inspect $CID | jq -r ".[0].NetworkSettings.Networks | to_entries[] | \"\(.key): \(.value.IPAddress)\"")
      output+="${line}|${IP}\n"
    fi
  done
  echo $output | column -t -s '|'
}

# Creates a temp file name and leverages it to swap to files "in place"
swap() {
  tmp_name=$(TMPDIR=$(dirname -- "$1") mktemp) &&
  mv -f -- "$1" "$tmp_name" &&
  mv -f -- "$2" "$1" &&
  mv -f -- "$tmp_name" "$2"
}

clean_merged_branches() {
  git checkout -q main && git for-each-ref refs/heads/ "--format=%(refname:short)" | \
  while read branch; do
    mergeBase=$(git merge-base main $branch) &&
    if [[ $(git cherry main $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]]; then
      read -q "REPLY?Would you like to delete branch: '${branch}'? (YyNn)"
      echo ""
      if [[ $? -eq 0 ]]; then
        git branch -D $branch;
        echo ""
      fi
    fi
   done
}

# Traverses PWD and up to find and autoload an nvmrc if exists. Compatible with lazy loading.
__lazy-autoload-nvmrc() {
  local _path=$PWD
  local nvmrc_path

  # If NVM hasn't yet been loaded, load it so all later nvm commands work
  __load_nvm

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
    unset -f nvm node npm
    if [[ -s "${NVM_DIR}/nvm.sh" ]]; then
      . "${NVM_DIR}/nvm.sh"
      export NVM_LOADED="true"
    fi
  fi
}

# Wrapper for BitWarden CLI to auto unlock vault and persist session when attempting to sync
bw() {
  if [[ $1 == "sync" ]]; then
    BW_STATUS=$(command bw status | jq -r .status)
    case "$BW_STATUS" in
      "unauthenticated")
        echo "Logging into BitWarden"
        TOKEN=$(command bw login --raw)
        if [[ $? -eq 0 ]]; then
          export BW_SESSION=${TOKEN}
        fi
        ;;
      "locked")
        echo "Unlocking Vault"
        TOKEN=$(command bw unlock --raw)
        if [[ $? -eq 0 ]]; then
          export BW_SESSION=${TOKEN}
        fi
        ;;
      "unlocked")
        ;;
      *)
        echo "Unknown Login Status: $BW_STATUS"
        return 1
        ;;
    esac
  fi

  command bw $@
}

cz() {
  case "$1" in
    'diff' | 'apply' | *'merge'* | 'update' )
      echo "Syncing BitWarden Vault"
      bw sync
      ;;
    *)
      ;;
  esac

  command chezmoi $@
}
