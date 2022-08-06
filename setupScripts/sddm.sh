#!/usr/bin/env bash
. ./setupScripts/helpers.sh

promptUser "Do you want to symlink the SDDM configuration?"
if [[ $? -eq 0 ]]; then
  sudo ln -sf "${PWD}"/sddm/sddm.conf /etc/sddm.conf
fi

promptUser "Do you want to symlink the SDDM Themes?"
if [[ $? -eq 0 ]]; then
  sudo ln -sf "${PWD}"/sddm/themes /usr/share/sddm/themes
fi

promptUser "Do you want to symlink the Xsetup?"
if [[ $? -eq 0 ]]; then
  sudo ln -sf "${PWD}"/sddm/Xsetup /usr/share/sddm/scripts/Xsetup
fi
