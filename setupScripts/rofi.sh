#!/usr/bin/env bash
. ./setupScripts/helpers.sh

promptUser "Do you want to symlink the Rofi configuration?"
if [[ $? -eq 0 ]]; then
  sudo ln -sf "${PWD}"/rofi/config.rasi ~/.config/rofi/config.rasi
fi

promptUser "Do you want to symlink the Rofi Themes?"
if [[ $? -eq 0 ]]; then
  sudo ln -sf "${PWD}"/rofi/themes ~/.config/rofi/themes
fi
