### Source: https://superuser.com/questions/902241/how-to-make-zsh-not-store-failed-command/902508#902508
 zshaddhistory() {
   local j=1
   while ([[ ${${(z)1}[$j]} == *=* ]]) {
     ((j++))
   }
   whence ${${(z)1}[$j]} >| /dev/null || return 1
}

# Fuzzy Command Wrapper
fuzzily() {
  local seperator='--'
  local seperator_index=${@[(ie)$seperator]}
  local fuzzy_prompt=(${@:1:(($seperator_index - 1))})
  local fuzzy_cmd=${@[(($seperator_index + 1))]}

  fzf --prompt="$fuzzy_prompt" --border --height=~25% --reverse --exit-0 
}


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
