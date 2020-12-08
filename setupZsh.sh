#!/bin/bash

#pstree -p $$ | tr ' ()' '\012\012\012' | grep -i "sh$" | grep -v "$0" | tail -1
#echo "Default Shell = $SHELL\n"

# Check to see if ZSH is already installed.
if ! hash zsh 2>/dev/null; then
  echo "Installing ZSH to your system."
  # Determine OS commands needed to install ZSH.
  if [[ $(uname) == 'Linux' ]]; then
    sudo apt -y install zsh
    echo "Installed ZSH via APT."
  elif [[ $(uname) == 'Darwin' ]]; then
    # Determine if brew is installed.
    if ! hash brew 2>/dev/null; then
      # Install Homebrew
      echo "Installing Homebrew to proceed with installing ZSH."
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    else
      echo "Updating Homebrew prior to installing ZSH"
      brew update
    fi
    brew install zsh
    echo "Installed ZSH via Homebrew."
  fi
else
  echo "ZSH is already installed."
fi

echo -n "Do you wish to make ZSH your default shell? (Yy/Nn)"
read answer
if [[ $answer != "${answer#[Yy]}" ]]; then
  if [[ $SHELL != $(command -v zsh) ]]; then
    echo "Making ZSH your default shell."
#    chsh -s $(command -v zsh)
  fi
    echo "ZSH was already your default shell."
fi
   
echo ""
echo -n "Do you wish to install Oh-My-Zsh?"
read answer
if [[ $answer != "${answer#[Yy]}" ]]; then
  echo "Installing Oh-My-Zsh."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

## The below is broken - please fix!!!

#echo "Copying ZSH shell config files to home dir."
#cp -a ./shellconfig/.* $HOME/
#echo "Copying ZSH theme to ZSH Themes dir."
#cp -a ./shellconfig/zed.zsh-theme $ZSH/custom/themes/

echo -n "Would you like to install the 'zsh-syntax-highlighting' plugin? (Yy/Nn)"
read answer
if [[ $answer != "${answer#[Yy]}" ]]; then
  echo "Cloning zsh-users/zsh-syntax-highlighting.git"
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
fi

echo -n "Would you like to install the 'history-search-multi-word' plugin? (Yy/Nn)"
read answer
if [[ $answer != "${answer#[Yy]}" ]]; then
  echo "Cloning zdharma/history-search-multi-word.git"
  git clone git://github.com/zdharma/history-search-multi-word.git $ZSH/custom/plugins/history-search-multi-word
fi

echo -n "Would you like to install the 'zsh-autosuggestions' plugin? (Yy/Nn)"
read answer
if [[ $answer != "${answer#[Yy]}" ]]; then
  echo "Cloning zsh-users/zsh-autosuggestions.git"
  git clone git://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
fi
 
echo "Installation of ZSH and Oh-My-Zsh is complete. Please restart your terminals for changes to take effect."

