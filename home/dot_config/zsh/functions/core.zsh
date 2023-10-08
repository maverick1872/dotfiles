### Source: https://superuser.com/questions/902241/how-to-make-zsh-not-store-failed-command/902508#902508
 zshaddhistory() {
   local j=1
   while ([[ ${${(z)1}[$j]} == *=* ]]) {
     ((j++))
   }
   whence ${${(z)1}[$j]} >| /dev/null || return 1
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


compdef '_path_files -/ -W ~/.vim-configs' swim
function swim {
  if [ $# -eq 0 ]
  then
    zmodload zsh/stat
    active=$(stat +link "$HOME/.config/nvim")
    echo "Swimming with ${${active}:t}"
    echo "$HOME/.config/nvim -> $active"
    zmodload -u zsh/stat
  else
    echo "Swimming with $1"
    ln -snfv ~/.config/nvim-configs/$1 ~/.config/nvim
  fi
}
