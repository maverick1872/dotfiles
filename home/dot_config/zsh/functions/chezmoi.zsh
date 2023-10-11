ch() {
  case "$1" in
    'diff' | 'apply' | *'merge'* | 'update' )
      echo "Syncing BitWarden Vault"
      bw sync
      ;;
    *)
      ;;
  esac

  command chezmoi $@
}
