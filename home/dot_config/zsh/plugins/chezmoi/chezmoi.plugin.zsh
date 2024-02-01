compdef _chezmoi ch
ch() {
  strict_mode
  case "$1" in
    'diff' | 'apply' | *'merge'* | 'update' | 'status' )
      echo "Syncing BitWarden Vault"
      bw sync
      ;;
    *)
      ;;
  esac

  command chezmoi $@
  strict_mode off
}
