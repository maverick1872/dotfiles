#!/bin/bash

ZshCustomDir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
echo "Current Working Dir '${PWD}'"
echo "Default Shell = ${SHELL}"
echo "Using ZSH Custom Dir of '${ZshCustomDir}'"

# Check to see if ZSH is already installed.
if ! command -v zsh &>/dev/null; then
  echo "Proceeding with installing ZSH."
  # Determine OS commands needed to install ZSH.
  if [[ $(uname) == 'Linux' ]]; then
    echo "Installing ZSH on Linux."
    sudo apt -y install zsh
    echo "Installed ZSH via APT."
  elif [[ $(uname) == 'Darwin' ]]; then
    echo "Installing ZSH on OSX."
    # Determine if brew is installed.
    if ! command -v brew &>/dev/null; then
      # Install Homebrew
      echo -n "Homebrew is required to install ZSH. Do you wish to install Homebrew? (Yy/Nn)"
      read -r answer
      if [[ $answer != "${answer#[Yy]}" ]]; then
        echo "Installing Homebrew to proceed with installing ZSH."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      else
        echo "Can not continue without Homebrew. Exiting..."
      fi
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

if [[ ${SHELL} != $(command -v zsh) ]]; then
  echo -n "Do you wish to make ZSH your default shell? (Yy/Nn)"
  read -r answer
  if [[ $answer != "${answer#[Yy]}" ]]; then
    echo "Making ZSH your default shell."
    chsh -s "$(command -v zsh)"
  else
    echo "Skipping..."
    echo ""
  fi
else
  echo "ZSH is already your default shell."
fi

echo ""
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  echo -n "Do you wish to install Oh-My-Zsh?"
  read -r answer
  if [[ $answer != "${answer#[Yy]}" ]]; then
    echo "Installing Oh-My-Zsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    echo "Skipping..."
    echo ""
  fi
else
  echo "Oh-My-ZSH is already installed"
fi

if [[ ! -d "${ZshCustomDir}/plugins/zsh-syntax-highlighting" ]]; then
  echo -n "Would you like to install the 'zsh-syntax-highlighting' plugin? (Yy/Nn)"
  read -r answer
  if [[ $answer != "${answer#[Yy]}" ]]; then
    echo "Cloning zsh-users/zsh-syntax-highlighting.git"
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git "${ZshCustomDir}"/plugins/zsh-syntax-highlighting
    #TODO:
    # - add zsh-syntax-highlighting tp .zshrc plugins list.
  else
    echo "Skipping..."
    echo ""
  fi
else
  echo "'zsh-syntax-highlighting' plugin is already installed"
fi

if [[ ! -d "${ZshCustomDir}/plugins/zsh-autosuggestions" ]]; then
  echo -n "Would you like to install the 'zsh-autosuggestions' plugin? (Yy/Nn)"
  read -r answer
  if [[ $answer != "${answer#[Yy]}" ]]; then
    echo "Cloning zsh-users/zsh-autosuggestions.git"
    git clone git://github.com/zsh-users/zsh-autosuggestions.git "${ZshCustomDir}"/plugins/zsh-autosuggestions
    #TODO
    #   - add zsh-autosuggestions to .zshrc plugins list.
    #   - add AUTOSUGGESTION="true" to .zshrc
  else
    echo "Skipping..."
    echo ""
  fi
else
  echo "'zsh-autosuggestions' plugin is already installed"
fi

if [[ ! -d "${ZshCustomDir}/plugins/history-search-multi-word" ]]; then
  echo -n "Would you like to install the 'history-search-multi-word' plugin? (Yy/Nn)"
  read -r answer
  if [[ $answer != "${answer#[Yy]}" ]]; then
    echo "Cloning zdharma/history-search-multi-word.git"
    git clone git://github.com/zdharma/history-search-multi-word.git "${ZshCustomDir}"/plugins/history-search-multi-word
    #TODO:
    # - add history-search-multi-word to .zshrc plugins list.
  else
    echo "Skipping..."
    echo ""
  fi
else
  echo "'history-search-multi-word' plugin is already installed"
fi

echo ""
echo -n "Would you like to apply the custom ZSH configurations contained within this repository? (Yy/Nn)"
read -r answer
if [[ $answer != "${answer#[Yy]}" ]]; then
  ## Should .zshrc be symlinked
  echo ""
  if [[ -f ${HOME}/.zshrc ]]; then
    echo -n "Do you want to overwrite ${HOME}/.zshrc with a symlink? (Yy/Nn)"
    read -r answer
    if [[ $answer != "${answer#[Yy]}" ]]; then
        ln -snf "${PWD}"/shellconfig/.zshrc "${HOME}"/.zshrc
        echo "Symlinked .zshrc to ${HOME}/.zshrc"
    else
      echo "Skipping..."
    fi
  else
    echo "Symlinked .zshrc to ${HOME}/.zshrc"
  fi

  ## Should aliases be symlinked
  echo ""
  if [[ -f ${ZshCustomDir}/aliases.zsh ]]; then
    echo -n "Do you want to overwrite ${ZshCustomDir}/aliases.zsh with a symlink? (Yy/Nn)"
    read -r answer
    if [[ $answer != "${answer#[Yy]}" ]]; then
        ln -snf "${PWD}"/shellconfig/aliases.zsh "${ZshCustomDir}"/aliases.zsh
        echo "Symlinked aliases to ${ZshCustomDir}/aliases.zsh"
    else
      echo "Skipping..."
    fi
  else
    ln -snf "${PWD}"/shellconfig/aliases.zsh "${ZshCustomDir}"/aliases.zsh
    echo "Symlinked aliases to ${ZshCustomDir}/aliases.zsh"
  fi

  ## Should functions be symlinked
  echo ""
  if [[ -f ${ZshCustomDir}/functions.zsh ]]; then
    echo -n "Do you want to overwrite ${ZshCustomDir}/functions.zsh with a symlink? (Yy/Nn)"
    read -r answer
    if [[ $answer != "${answer#[Yy]}" ]]; then
        ln -snf "${PWD}"/shellconfig/functions.zsh "${ZshCustomDir}"/functions.zsh
        echo "Symlinked functions to ${ZshCustomDir}/functions.zsh"
    else
      echo "Skipping..."
    fi
  else
    ln -snf "${PWD}"/shellconfig/functions.zsh "${ZshCustomDir}"/functions.zsh
    echo "Symlinked functions to ${ZshCustomDir}/functions.zsh"
  fi

  ## Should themes be copied over
  echo ""
  echo -n "Do you want to copy all themes with a symlink? (Yy/Nn)"
  read -r answer
  if [[ $answer != "${answer#[Yy]}" ]]; then
      if [[ -d "${ZshCustomDir}"/themes ]]; then
        echo "${ZshCustomDir}/themes already exists and is a directory."
        echo -n "Should ${ZshCustomDir}/themes be removed and be replaced with a symlink? (Yy/Nn)"
        read -r answer
        if [[ $answer != "${answer#[Yy]}" ]]; then
          rm -rf "${ZshCustomDir}"/themes
          ln -snf "${PWD}"/shellconfig/themes "${ZshCustomDir}"
          echo "Symlinked themes to ${ZshCustomDir}/themes"
        else
          echo "Skipping..."
        fi
      else
        ln -snf "${PWD}"/shellconfig/themes "${ZshCustomDir}"
        echo "Symlinked themes to ${ZshCustomDir}/themes"
      fi
  else
    echo "Skipping..."
  fi
else
  echo "Skipping..."
fi

echo ""
echo "Installation of ZSH and Oh-My-Zsh is complete. Please restart your terminals for changes to take effect."
exit
