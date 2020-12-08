# Traverses directory structure and pulls any changes in the git repo
zsh_plugin_update() {
  for d in $(find ${HOME}/.oh-my-zsh/custom/plugins/ -maxdepth 1 -type d); do cd $d; git pull; cd -; done
}

## Pulls personal customization updates down and applies them to local users zsh configurations
#update_zsh_customizations() {
#
#}
#
## Lists all branches that are considered merged in the current dirs git repo
#list_merged() {
#  for branch in `git branch -r --merged | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
#}
#
## Lists all branches that are considered unmerged in the current dirs git repo
#list_unmerged() {
#  for branch in `git branch -r --no-merged | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
#}

# Copies and ssh key to the specified server via a ssh session
ssh_copy_id() {
  local ssh_connection=${1}
  local ssh_key=${2:-~/.ssh/id_rsa.pub}
  if [[ "${ssh_connection}" == "" ]]; then
    echo "ssh connection string required";
    exit 1;
  fi
  cat ${ssh_key} | ssh ${ssh_connection} "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys"
}

# Short-hand to grep all aliases available
function search-aliases {
    alias | grep "$1" --color;
}