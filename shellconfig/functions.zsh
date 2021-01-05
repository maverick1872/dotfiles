# Traverses directory structure and pulls any changes in the git repo
update-zsh-plugins() {
  for d in $(find ${ZSH_CUSTOM}/plugins -maxdepth 1 -mindepth 1 ! -name 'example' -type d); do
    echo "Updating custom plugin: $(basename "$d")"
    cd $d || return
    git pull
    cd - > /dev/null || return
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
  omz update
  update-zsh-customizations
  update-zsh-plugins
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

gcl-from-user() {
  gcl "git@github.com-$1:$1/$2.git" "${DEV_DIR}/$1/$2"
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
