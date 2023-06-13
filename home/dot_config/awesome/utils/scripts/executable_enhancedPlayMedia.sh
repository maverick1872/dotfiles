#!/usr/bin/env zsh

playerctl --all-players status
playersFound=$?

# If no player is available, start spotify
if [[ playersFound -ne 0 ]]; then
  spotify &
  sleep 2
fi

playerStatus=($(playerctl --all-players status))
playerNames=($(playerctl --all-players -f '{{playerName}}' status))
targetPlayerIdx=$playerStatus[(Ie)Playing]

# Determine least priority player to pause first
if [[ $targetPlayerIdx > 0 ]]; then
  overallStatus='Playing'
  targetPlayer=${playerNames[$targetPlayerIdx]}
else
  overallStatus='Paused'
fi

# Pause all players prior to starting a player
case $overallStatus in
  'Paused')
    playerctl play
    ;;
 'Playing')
    playerctl --player=$targetPlayer pause
    ;;
esac

