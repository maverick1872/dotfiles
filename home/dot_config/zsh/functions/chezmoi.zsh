ch() {
  case "$1" in
    'diff' | 'apply' | *'merge'* | 'update' )
      echo "Syncing BitWarden Vault"
      bw sync
      ;;
    'edit')
      command chezmoi $@ --apply
      ;;
    *)
      ;;
  esac

  command chezmoi $@
}
