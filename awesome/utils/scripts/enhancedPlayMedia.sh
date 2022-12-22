playerctl status
playerStatus=$?

if [[ playerStatus -ne 0 ]]; then
  spotify &
  sleep 2
fi

playerctl --player=spotify,%any play-pause
c