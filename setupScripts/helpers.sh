#!/usr/bin/env bash
CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config/}

promptUser() {
  echo -e "$1 (Yy/Nn)\c"
  read -r answer
  if [[ $answer != "${answer#[Yy]}" ]]; then
    return 0
  else
    return 1
  fi
}
