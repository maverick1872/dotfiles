# Checkout Github PR
gcopr() {
  if [[ -n $1 ]]; then
    gh pr checkout "$1"
  else
    GH_FORCE_TTY=100% gh pr list \
      | fzf --prompt='Filter PRs: ' \
        --border \
        --height '~50%' \
        --reverse \
        --ansi \
        --header-lines 3 \
        --preview 'GH_FORCE_TTY=100% gh pr view {1}' \
        --preview-window 'down' \
      | awk '{print $1}' | xargs gh pr checkout
  fi
}

# View Github PR
viewpr() {
  selection=($(
    export GH_FORCE_TTY=100%;
    gh search prs --state=open --author=@me --sort=updated | tail +4 \
    | fzf --prompt='Filter PRs: ' \
      --border \
      --height '~50%' \
      --reverse \
      --ansi \
      --header-lines 1 \
      --preview 'gh pr -R {1} view {2}' \
      --preview-window 'down'
  ))
  if [[ $selection ]]; then
    gh pr -R ${selection[1]} view -w ${selection[2]}
  fi
}

# Open Github Repo
viewrepo() {
  gh repo view -w
}

# Github CLI
alias newpr='gh pr create'
alias prsToReview='gh search prs --state=open --review-requested=@me'
alias prsOpen='gh search prs --state=open --author=@me'

