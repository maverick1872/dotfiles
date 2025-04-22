#!/usr/bin/env zsh

run() {
  cmd_esc=$(echo "$*" | sed 's/[^-A-Za-z0-9_]/\\&/g') 
  results=$(pgrep -acxf "$cmd_esc")
  echo "Instances app running: $results - '$cmd_esc'" | logger --tag awesomewm
  if [[ $results -eq 0 ]]; then
    echo "Application is not already running. Starting..." | logger --tag awesomewm
    "$@" &
  else
  fi
}

run picom -b
run flameshot
run xidlehook --not-when-audio --timer 300 '$AWESOME_CONFIG/utils/scripts/lockscreen.sh' ''
run xidlehook --not-when-audio --timer 3600 'systemctl suspend' ''

