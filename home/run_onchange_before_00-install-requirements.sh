#!/usr/bin/env bash

if [[ "${OS_DISTRIBUTION}" == "darwin"* ]]; then
  xcode-select --install

  which -s nvm
  if [[ $? != 0 ]] ; then
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)"
  fi
elif [[ "${OS_DISTRIBUTION}" == "linux-arch" ]]; then
  sudo pacman -Syuq --noconfirm --needed # Update all currently installed packages
  sudo pacman -Sq --noconfirm --needed - <<EOF
base
base-devel
zsh
git
openssh
EOF

  which yay
  if [[ $? != 0 ]] ; then
    git clone --quiet https://aur.archlinux.org/yay-bin.git # Get yay source (AUR helper)
    cd yay-bin && makepkg -si --noconfirm # build and install yay
    yay --version
  fi
fi

