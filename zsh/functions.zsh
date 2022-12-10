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

# Traverses directory structure and pulls any changes in the git repo
update-zsh-plugins() {
  for d in $(find ${ZSH_CUSTOM}/plugins -maxdepth 1 -mindepth 1 ! -name 'example' -type d); do
    echo "Updating custom plugin: $(basename "$d")"
    cd $d || return
    git pull
    cd - > /dev/null || return
  done
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

## Convenience function to update personal ZSH customizations
update-zsh-customizations() {
  cd ${DEV_DIR}/Maverick1872/dotfiles || return
  echo "Updating personal zsh customizations"
  git pull
  cd - > /dev/null || return
}

## Update all things shell related
update-shell() {
  omz update && update-zsh-customizations && update-zsh-plugins
}

# Short-hand to grep all aliases available
search-aliases() {
  alias | grep "$1" --color
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

  # Traverse parent directories until an nvmrc is encountered
  while [[ "${_path}" != "" && ! -e "${_path}/.nvmrc" ]]; do
    _path=${_path%/*}
  done

  # Check if nvmrc exists in the final directory from above
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