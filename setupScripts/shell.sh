#!/usr/bin/env bash
. ./setupScripts/helpers.sh

ZshCustomDir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
# echo "Current Working Dir '${PWD}'"
echo "Current Default Shell = ${SHELL}"
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
      promptUser "Homebrew is required to install ZSH. Do you wish to install Homebrew?"
      if [[ $? -eq 0 ]]; then
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
  promptUser "Do you wish to make ZSH your default shell?"
  if [[ $? -eq 0 ]]; then
    echo "Making ZSH your default shell."
    chsh -s "$(command -v zsh)"

    echo -e "Skipping...\n"
  fi
else
  echo -e "ZSH is already your default shell.\n"
fi

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  promptUser "Do you wish to install Oh-My-Zsh?"
  if [[ $? -eq 0 ]]; then
    echo "Installing Oh-My-Zsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    echo -e "Skipping...\n"
  fi
else
  echo "Oh-My-ZSH is already installed"
fi

if [[ ! -d "${ZshCustomDir}/plugins/zsh-syntax-highlighting" ]]; then
  promptUser "Would you like to install the 'zsh-syntax-highlighting' plugin?"
  if [[ $? -eq 0 ]]; then
    echo "Cloning zsh-users/zsh-syntax-highlighting.git"
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git "${ZshCustomDir}"/plugins/zsh-syntax-highlighting
    #TODO:
    # - add zsh-syntax-highlighting tp .zshrc plugins list.
  else
    echo -e "Skipping...\n"
  fi
else
  echo "'zsh-syntax-highlighting' plugin is already installed"
fi

if [[ ! -d "${ZshCustomDir}/plugins/zsh-autosuggestions" ]]; then
  promptUser "Would you like to install the 'zsh-autosuggestions' plugin?"
  if [[ $? -eq 0 ]]; then
    echo "Cloning zsh-users/zsh-autosuggestions.git"
    git clone git://github.com/zsh-users/zsh-autosuggestions.git "${ZshCustomDir}"/plugins/zsh-autosuggestions
    #TODO
    #   - add zsh-autosuggestions to .zshrc plugins list.
    #   - add AUTOSUGGESTION="true" to .zshrc
  else
    echo -e "Skipping...\n"
  fi
else
  echo "'zsh-autosuggestions' plugin is already installed"
fi

if [[ ! -d "${ZshCustomDir}/plugins/history-search-multi-word" ]]; then
  promptUser "Would you like to install the 'history-search-multi-word' plugin?"
  if [[ $? -eq 0 ]]; then
    echo "Cloning zdharma-continuum/history-search-multi-word.git"
    git clone git://github.com/zdharma-continuum/history-search-multi-word.git "${ZshCustomDir}"/plugins/history-search-multi-word
    #TODO:
    # - add history-search-multi-word to .zshrc plugins list.
  else
    echo -e "Skipping...\n"
  fi
else
  echo "'history-search-multi-word' plugin is already installed"
fi

promptUser "Would you like to apply the custom ZSH configurations contained within this repository?"
if [[ $? -eq 0 ]]; then
  ## Should .zshrc be symlinked
  if [[ -f ${HOME}/.zshrc ]]; then
    promptUser "Do you want to overwrite ${HOME}/.zshrc?"
    if [[ $? -eq 0 ]]; then
        rm "${HOME}"/.zshrc
        cp -f "${PWD}"/zsh/config "${HOME}"/.zshrc
        echo "Overwrote ${PWD}/zsh/config to ${HOME}/.zshrc"
    else
      echo "Skipping..."
    fi
  else
    cp "${PWD}"/zsh/config "${HOME}"/.zshrc
    echo "Copied ${PWD}/zsh/config to ${HOME}/.zshrc"
  fi

  ## Should private aliases file be created
  if [[ ! -f ${ZshCustomDir}/private-aliases.zsh ]]; then
    touch "${ZshCustomDir}"/private-aliases.zsh
    echo "Created ${ZshCustomDir}/private-aliases.zsh to maintain aliases custom to this machine"
  fi
 
  ## Should aliases be symlinked
  if [[ -f ${ZshCustomDir}/aliases.zsh ]]; then
    promptUser "Do you want to overwrite ${ZshCustomDir}/aliases.zsh with a symlink?"
    if [[ $? -eq 0 ]]; then
        ln -snf "${PWD}"/zsh/aliases.zsh "${ZshCustomDir}"/aliases.zsh
        echo "Symlinked aliases to ${ZshCustomDir}/aliases.zsh"
    else
      echo "Skipping..."
    fi
  else
    ln -snf "${PWD}"/zsh/aliases.zsh "${ZshCustomDir}"/aliases.zsh
    echo "Symlinked aliases to ${ZshCustomDir}/aliases.zsh"
  fi

  ## Should functions be symlinked
  if [[ -f ${ZshCustomDir}/functions.zsh ]]; then
    promptUser "Do you want to overwrite ${ZshCustomDir}/functions.zsh with a symlink?"
    if [[ $? -eq 0 ]]; then
        ln -snf "${PWD}"/zsh/functions.zsh "${ZshCustomDir}"/functions.zsh
        echo "Symlinked functions to ${ZshCustomDir}/functions.zsh"
    else
      echo "Skipping..."
    fi
  else
    ln -snf "${PWD}"/zsh/functions.zsh "${ZshCustomDir}"/functions.zsh
    echo "Symlinked functions to ${ZshCustomDir}/functions.zsh"
  fi

  ## Should themes be copied over
  promptUser "Do you want to copy all themes with a symlink?"
  if [[ $? -eq 0 ]]; then
    ln -snf "${PWD}"/zsh/themes/* "${ZshCustomDir}/themes"
    echo "Symlinked themes to ${ZshCustomDir}/themes"
  else
    echo "Skipping..."
  fi
else
  echo "Skipping..."
fi

echo ""
echo "Installation of ZSH and Oh-My-Zsh is complete. Please restart your terminals for changes to take effect."
exit
