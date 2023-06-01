#!/usr/bin/env zsh

## Install XCode CLI Tools
xcode-select -p
if [[ $? != 0 ]] ; then
  xcode-select --install
fi


## Install NVM
which -s nvm
if [[ $? != 0 ]] ; then
 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)"
fi

## Install Base Brewfile
## brewfile hash: {{ include "bootstrap/brewfile" | sha256sum }}
brew bundle --no-lock --file={{ joinPath .chezmoi.sourceDir "bootstrap/brewfile" | quote }}


if [[ "${IS_PERSONAL}" == "true" ]]; then

## Install Rust toolchain non-interactively
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

## Install Personal Brewfile
## brewfile hash: {{ include "bootstrap/brewfile.personal" | sha256sum }}
brew bundle --no-lock --file={{ joinPath .chezmoi.sourceDir "bootstrap/brewfile.personal" | quote }}

else

## Install Work Brewfile
# brewfile hash: {{ include "bootstrap/brewfile.work" | sha256sum }}
brew bundle --no-lock --file={{ joinPath .chezmoi.sourceDir "bootstrap/brewfile.work" | quote }}

fi

