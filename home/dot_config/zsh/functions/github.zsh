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
  gh pr view "$1" --web
}

# Open Github Repo
viewrepo() {
  gh repo --web
}

