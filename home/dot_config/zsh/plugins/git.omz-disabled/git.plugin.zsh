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

ac() {
  git add $(git rev-parse --show-toplevel)
  git commit -m "$*"
}

acp() {
  ac $*
  git push
}

uc() {
  git add -u
  git commit -m "$*"
}

ucp() {
  uc $*
  git push
}

# unalias gcb
# gcb() {
#   git switch -c $1 || git switch $1
# }

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

alias gst='git status'
# Overwrite ghostscript cause it's annoying
alias gs='gst'
alias glo='git log --pretty=format:"%Cred%cs%Creset - %C(auto)%h%Creset - %<(16,trunc)%Cgreen%an%Creset - %s %C(auto)%d" --date=local'
alias gcuwm='gau && gcmsg'
alias gdom='git diff origin/$(git_main_branch)'
alias gdod='git diff origin/$(git_develop_branch)'
alias gbdlocal='git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d'
alias gmod='git merge origin/$(git_develop_branch)'
