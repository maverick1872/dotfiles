unset -f git_develop_branch
unset -f git_main_branch
function git_main_branch() {
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

function git_develop_branch() {
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

reload-zsh() {
  source ~/.zshenv
  source ~/.zshrc
}
## Lists all branches that are considered merged in the current dirs git repo
#list_merged() {
#  for branch in `git branch -r --merged | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
#}
#
## Lists all branches that are considered unmerged in the current dirs git repo
#list_unmerged() {
#  for branch in `git branch -r --no-merged | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
#}
