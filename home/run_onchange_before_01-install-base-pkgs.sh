#!/usr/bin/env bash

if [[ "${OS_DISTRIBUTION}" == "darwin" ]]; then
  echo "Installing packages with brew"
  brew bundle --no-lock --file=/dev/stdin <<EOF
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"
tap "homebrew/services"
tap "homebrew/cask-fonts"

cask "docker"
cask "firefox"
cask "iterm2"
cask "spotify"
cask "rar"
cask "font-source-code-pro" #subject to change
cask "postman"
cask "gpg-suite"

brew "bitwarden-cli"
brew "coreutils"
brew "git"
brew "gh"
brew "jq"
brew "yq"
brew "neovim"
brew "ripgrep"
brew "tealdeer"
brew "wget"
brew "nghttp2" # HTTP2 Client
brew "ffmpeg" 
EOF
elif [[ "${OS_DISTRIBUTION}" == "linux-arch" ]]; then
  echo "Installing packages with yay"
  yay -Sq --noconfirm --needed - <<EOF
alsa-utils
amd-ucode
appimagelauncher-git
arandr
awesome-git
bc
bind
bitwarden
bluez-utils
btop
caddy
ddrescue
discord
dive-bin
docker-compose
ethtool
feh
firefox
flameshot
fzf
github-cli
go-yq
grub
jq
kitty
linux-headers
linux-lts
man-db
man-pages
mumble
nomachine
nvm
pavucontrol
piper
playerctld-systemd-unit
ranger
ripgrep
rofi
sddm-theme-aerial-git
signal-desktop
spotify
steam
tealdeer
termdown
thunar
unzip
wget
xclip
xdotool
xf86-video-amdgpu
xorg-xev
xorg-xinit
zip
zsa-wally
EOF
elif [[ "${OS_DISTRIBUTION}" == "linux-debian" ]]; then
  echo "Installing packages with apt"
  sudo apt update && sudo apt install <<EOF
ripgrep
tealdeer
EOF
fi
