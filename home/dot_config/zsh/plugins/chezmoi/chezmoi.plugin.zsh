compdef _chezmoi ch

ch() {
  strict_mode
  case "$1" in
    'diff' | 'apply' | *'merge'* | 'update' | 'status' )
      echo "Syncing BitWarden Vault"
      bw sync
      ;;
    'clean' )
      shift  # Remove 'clean' from arguments
      _ch_clean "$@"
      strict_mode off
      return
      ;;
    *)
      ;;
  esac

  command chezmoi $@
  strict_mode off
}


# Interactive cleaning of files that are not managed by chezmoi
_ch_clean() {
  local unmanaged_files
  unmanaged_files=$(chezmoi unmanaged $1)
  
  if [[ -z "$unmanaged_files" ]]; then
    echo "No unmanaged files found."
    return 0
  fi
  
  echo "Unmanaged files found:"
  echo "$unmanaged_files" | nl -w3 -s") "
  
  echo ""
  echo "Options:"
  echo "a) Add all files to chezmoi"
  echo "r) Remove all files"
  echo "i) Interactive mode (decide file by file)"
  echo "q) Quit without changes"
  echo ""
  
  read -k 1 "choice?What would you like to do? (a/r/i/q) "
  echo ""
  
  case "$choice" in
    a|A)
      echo "Adding all unmanaged files to chezmoi..."
      echo "$unmanaged_files" | while read -r file; do
        if [[ -n "$file" ]]; then
          echo "Adding $file"
          chezmoi add "$HOME/$file"
        fi
      done
      ;;
    r|R)
      echo "Removing all files..."
      echo "$unmanaged_files" | while read -r file; do
        if [[ -n "$file" ]]; then
          echo "Removing $file"
          rm! "$HOME/$file"
        fi
      done
      ;;
    i|I)
      echo "Interactive mode selected."
      echo "$unmanaged_files" | while read -r file; do
        if [[ -n "$file" ]]; then
          echo ""
          echo "File: $file"
          echo "a) Add to chezmoi"
          echo "r) Remove"
          echo "s) Skip"
          echo "q) Quit"
          
          read -k 1 "action?Action? (a/s/q) "
          echo ""
          
          case "$action" in
            a|A)
              echo "Adding $file"
              chezmoi add "$HOME/$file"
              ;;
            r|R)
              echo "Removing $file"
              rm! "$HOME/$file"
              ;;
            q|Q)
              echo "Quitting."
              break
              ;;
            *)
              echo "Skipping $file"
              ;;
          esac
        fi
      done
      ;;
    *)
      echo "No changes made."
      ;;
  esac
}

