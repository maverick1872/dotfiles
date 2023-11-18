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
  local flags=()
  local non_flags=()

  # Separate options (strings starting with '-') from any other argument
  for arg in "$*"; do
    if [[ $arg == -* ]]; then
      flags+=("$arg")
    else
      non_flags+=("$arg")
    fi
  done

  git add $(git rev-parse --show-toplevel)
  git commit ${flags[@]} -m "${non_flags[@]}"
}

acp() {
  ac $*
  git push
}

uc() {
  local flags=()
  local non_flags=()

  # Separate options (strings starting with '-') from any other argument
  for arg in "$*"; do
    if [[ $arg == -* ]]; then
      flags+=("$arg")
    else
      non_flags+=("$arg")
    fi
  done

  git add -u
  git commit ${flags[@]} -m "${non_flags[@]}"
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

# Random
alias g=git
alias gcf='git config --list'
alias gclean='git clean --interactive -d'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gfg='git ls-files | grep'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'

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
alias gc='git commit --verbose'
alias 'gc!'='git commit --verbose --amend'
alias gca='git commit --verbose --all'
alias 'gca!'='git commit --verbose --all --amend'
alias gcam='git commit --all --message'
alias 'gcan!'='git commit --verbose --all --no-edit --amend'
alias 'gcans!'='git commit --verbose --all --signoff --no-edit --amend'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcs='git commit --gpg-sign'
alias gcsm='git commit --signoff --message'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
alias 'gcn!'='git commit --verbose --no-edit --amend'

# Git Checkout
alias gcb='git checkout -b'
alias gco='git checkout'
alias gcd='git checkout $(git_develop_branch)'
alias gcm='git checkout $(git_main_branch)'

# Cherry Pick
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# Git Diff
alias gd='git diff'
alias gdca='git diff --cached'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'
alias gdom='git diff origin/$(git_main_branch)'
alias gdod='git diff origin/$(git_develop_branch)'

# Git Fetch
alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'
alias gfo='git fetch origin'

# Git Pull
alias gl='git pull'
alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'
alias gpr='git pull --rebase'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'
alias gprom='git pull --rebase origin $(git_main_branch)'
alias gpromi='git pull --rebase=interactive origin $(git_main_branch)'
alias gprv='git pull --rebase -v'

# Git Ignore
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gunignore='git update-index --no-assume-unchanged'

# Git Log
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat --patch'
alias glo='git log --pretty=format:"%Cred%cs%Creset - %C(auto)%h%Creset - %<(16,trunc)%Cgreen%an%Creset - %s %C(auto)%d" --date=local'
# alias glo='git log --oneline --decorate'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'

# Git Merge
alias gm='git merge'
alias gma='git merge --abort'
alias gmom='git merge origin/$(git_main_branch)'
alias gmod='git merge origin/$(git_develop_branch)'
alias gms='git merge --squash'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'

# Git Push
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease --force-if-includes'
alias 'gpf!'='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'
alias gpu='git push upstream'
alias gpv='git push --verbose'


# Git Remotes
alias gr='git remote'
alias gra='git remote add'
alias grmv='git remote rename'
alias grset='git remote set-url'
alias grrm='git remote remove'
alias grup='git remote update'
alias grv='git remote --verbose'

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
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

# Git Reset
alias grh='git reset'
alias gru='git reset --'
alias gpristine='git reset --hard && git clean --force -dfx'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
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
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstall='git stash --all'
alias gstc='git stash clear'
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
