# Short-hand to grep all aliases available
search-aliases() {
  alias | grep "$1" --color
}

# Short-hand for search and replace leveraging ripgrep
rg-sr() {
  rg $1 --files-with-matches | xargs -p sed -i '' "s|${1}|${2}|g"
}

# Creates a temp file name and leverages it to swap to files "in place"
swap() {
  tmp_name=$(TMPDIR=$(dirname -- "$1") mktemp) &&
  mv -f -- "$1" "$tmp_name" &&
  mv -f -- "$2" "$1" &&
  mv -f -- "$tmp_name" "$2"
}

# Find process running on specified port
show-port() {
  lsof -P -n -i :"$1"
}
