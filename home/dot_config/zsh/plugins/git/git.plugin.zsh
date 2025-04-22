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

## Git commit with message
gc() {
  local flags=()
  local non_flags=()

  # Separate options (strings starting with '-') from any other argument
  for arg in "$*"; do
    if [ -n "$arg" ]; then
      if [[ $arg == -* ]]; then
        flags+=("$arg")
      else
        non_flags+=("$arg")
      fi
    fi
  done

  if [[ ${#non_flags[@]} -gt 0 ]]; then
    git commit "${flags[@]}" -m "${non_flags[@]}"
  else
    git commit "${flags[@]}"
  fi}

## Commit staged files and push
gcp() {
  gc $*
  git push
}

## Commit all
ac() {
  git add $(git rev-parse --show-toplevel)
  gc $*
}

## Commit all and push
acp() {
  ac $*
  git push
}

## Commit tracked files
uc() {
  git add -u
  gc $*
}

## Commit tracked files and push
ucp() {
  uc $*
  git push
}

# unalias gcb
# gcb() {
#   git switch -c $1 || git switch $1
# }

## Git Stash w/ message
gsta() {
  git stash push -m "$*"
}

gstas() {
  git stash push --staged -m "$*"
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

# Random
alias gcf='git config --list'
alias gclean='git clean --interactive -d'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gfg='git ls-files | grep'

# Git Add
alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'

# Git apply
alias gap='git apply'

# Git Branch
alias gb='git branch'
alias gbD='git branch --delete --force'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | awk '\''{print $1}'\'' | xargs git branch -D'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | awk '\''{print $1}'\'' | xargs git branch -d'
alias gbsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gbdlocal='git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d'

# Git Bisect
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

# Git Commit
alias gcmsg='git commit --message'
alias 'gc!'='git commit --verbose --amend'
alias gca='git commit --verbose --all'
alias 'gca!'='git commit --verbose --all --amend'

# Git Checkout
alias gcb='git checkout -b'
alias gco='git checkout'
alias gcd='git checkout $(git_develop_branch)'
alias gcm='git checkout $(git_main_branch)'

# Cherry Pick
alias gchp='git cherry-pick'
alias gchpa='git cherry-pick --abort'
alias gchpc='git cherry-pick --continue'

# Git Diff
alias gd='git diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdup='git diff --cached @{upstream}'
alias gdom='git diff origin/$(git_main_branch)'
alias gdod='git diff origin/$(git_develop_branch)'

# Git Fetch
alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'

# Git Pull
alias gl='git pull'

# Git Log
alias glg='git log --stat'
alias glo='git log --pretty=format:"%Cred%cs%Creset - %C(auto)%h%Creset - %<(16,trunc)%Cgreen%an%Creset - %s %C(auto)%d" --date=local'

# Git Merge
alias gm='git merge'
alias gma='git merge --abort'
alias gmom='git merge origin/$(git_main_branch)'
alias gmod='git merge origin/$(git_develop_branch)'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'

# Git Push
alias gp='git push'
alias gpf='git push --force-with-lease --force-if-includes'
alias gpoat='git push origin --all && git push origin --tags'
alias gpu='git push upstream'
alias gpv='git push --verbose'

# Git Rebase
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias grbo='git rebase --onto'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbs='git rebase --skip'

# Git Reset
alias gr='git reset'
alias gru='git reset --'
alias gpristine='git reset --hard && git clean --force -dfx'
alias grh='git reset --hard'
alias grk='git reset --keep'
alias grs='git reset --soft'
alias groh='git reset origin/$(git_current_branch) --hard'

# Git Revert
alias grev='git revert'

# Git Remove
alias grm='git rm'
alias grmc='git rm --cached'

# Git Restore
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'

# Git Status
# Overwrite ghostscript cause it's annoying
alias gs='gst'
alias gst='git status'
alias gsb='git status --short --branch'
alias gss='git status --short'

# Git Show
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'

# Git Stash
alias gstall='git stash --all'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'

# Git Switch
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'

# Git Tag
alias gta='git tag --annotate'
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'
