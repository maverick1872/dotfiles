# Checkout Github PR
gcopr() {
  gh pr checkout "$1"
}

# View Github PR
viewpr() {
  gh pr view "$1" --web
}

# Open Github Repo
viewrepo() {
  gh repo --web
}

