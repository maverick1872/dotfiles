# Wrapper for BitWarden CLI to auto unlock vault and persist session when attempting to sync
bw() {
  if [[ ! -d "${HOME}/.cache/bw" ]]; then
    mkdir -p ${HOME}/.cache/bw
  fi

  if [[ -z "${BW_SESSION}" ]] && [[ -f "${HOME}/.cache/bw/session" ]]; then
    export BW_SESSION=$(cat ${HOME}/.cache/bw/session)
  fi

  case "$1" in 
    "sync")
      BW_STATUS=$(command bw status | jq -r .status)
      case "$BW_STATUS" in
        "unauthenticated")
          echo "Logging into BitWarden"
          TOKEN=$(command bw login --raw)
          if [[ $? -eq 0 ]]; then
            export BW_SESSION=${TOKEN}
            echo ${TOKEN} > ${HOME}/.cache/bw/session
          fi
          ;;
        "locked")
          echo "Unlocking Vault"
          TOKEN=$(command bw unlock --raw)
          if [[ $? -eq 0 ]]; then
            export BW_SESSION=${TOKEN}
            echo ${TOKEN} > ${HOME}/.cache/bw/session
          fi
          ;;
        "unlocked")
          ;;
        *)
          echo "Unknown Login Status: $BW_STATUS"
          return 1
          ;;
      esac
      ;;
    "lock" | "logout")
      rm ${HOME}/.cache/bw/session
      ;;
  esac
  # fi

  command bw $@
}

