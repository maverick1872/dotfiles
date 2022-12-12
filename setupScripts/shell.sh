#!/usr/bin/env bash
. ./setupScripts/helpers.sh

ZshCustomDir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
# echo "Current Working Dir '${PWD}'"
echo -e "Current Default Shell = ${SHELL}"
echo -e "Using ZSH Custom Dir of '${ZshCustomDir}'"

# Check to see if ZSH is already installed.
if ! command -v zsh &>/dev/null; then
  echo -e "Proceeding with installing ZSH."
  # Determine OS commands needed to install ZSH.
  if [[ $(uname) == 'Linux' ]]; then
    echo -e "Installing ZSH on Linux."
    sudo apt -y install zsh
    echo -e "Installed ZSH via APT."
  elif [[ $(uname) == 'Darwin' ]]; then
    echo -e "Installing ZSH on OSX."
    # Determine if brew is installed.
    if ! command -v brew &>/dev/null; then
      # Install Homebrew
      promptUser "Homebrew is required to install ZSH. Do you wish to install Homebrew?"
      if [[ $? -eq 0 ]]; then
        echo -e "Installing Homebrew to proceed with installing ZSH."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      else
        echo -e "Can not continue without Homebrew. Exiting..."
      fi
    else
      echo -e "Updating Homebrew prior to installing ZSH"
      brew update
    fi
    brew install zsh
    echo -e "Installed ZSH via Homebrew."
  fi
else
  echo -e "ZSH is already installed."
fi

if [[ ${SHELL} != $(command -v zsh) ]]; then
  promptUser "Do you wish to make ZSH your default shell?"
  if [[ $? -eq 0 ]]; then
    echo -e "Making ZSH your default shell."
    chsh -s "$(command -v zsh)"

    echo -e "Skipping...\n"
  fi
else
  echo -e "ZSH is already your default shell.\n"
fi

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  promptUser "Do you wish to install Oh-My-Zsh?"
  if [[ $? -eq 0 ]]; then
    echo -e "Installing Oh-My-Zsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    echo -e "Skipping...\n"
  fi
else
  echo -e "Oh-My-ZSH is already installed"
fi

if [[ ! -d "${ZshCustomDir}/plugins/zsh-syntax-highlighting" ]]; then
  promptUser "Would you like to install the 'zsh-syntax-highlighting' plugin?"
  if [[ $? -eq 0 ]]; then
    echo -e "Cloning zsh-users/zsh-syntax-highlighting.git"
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git "${ZshCustomDir}"/plugins/zsh-syntax-highlighting
    #TODO:
    # - add zsh-syntax-highlighting tp .zshrc plugins list.
  else
    echo -e "Skipping...\n"
  fi
else
  echo -e "'zsh-syntax-highlighting' plugin is already installed"
fi

if [[ ! -d "${ZshCustomDir}/plugins/zsh-autosuggestions" ]]; then
  promptUser "Would you like to install the 'zsh-autosuggestions' plugin?"
  if [[ $? -eq 0 ]]; then
    echo -e "Cloning zsh-users/zsh-autosuggestions.git"
    git clone git://github.com/zsh-users/zsh-autosuggestions.git "${ZshCustomDir}"/plugins/zsh-autosuggestions
    #TODO
    #   - add zsh-autosuggestions to .zshrc plugins list.
    #   - add AUTOSUGGESTION="true" to .zshrc
  else
    echo -e "Skipping...\n"
  fi
else
  echo -e "'zsh-autosuggestions' plugin is already installed"
fi

if [[ ! -d "${ZshCustomDir}/plugins/history-search-multi-word" ]]; then
  promptUser "Would you like to install the 'history-search-multi-word' plugin?"
  if [[ $? -eq 0 ]]; then
    echo -e "Cloning zdharma-continuum/history-search-multi-word.git"
    git clone git://github.com/zdharma-continuum/history-search-multi-word.git "${ZshCustomDir}"/plugins/history-search-multi-word
    #TODO:
    # - add history-search-multi-word to .zshrc plugins list.
  else
    echo -e "Skipping...\n"
  fi
else
  echo -e "'history-search-multi-word' plugin is already installed"
fi

promptUser "Would you like to apply the custom ZSH configurations contained within this repository?"
if [[ $? -eq 0 ]]; then
  ## Should .zshrc be symlinked
  if [[ -f ${HOME}/.zshrc ]]; then
    promptUser "Do you want to overwrite ${HOME}/.zshrc with a symlink?"
    if [[ $? -eq 0 ]]; then
        if [[ ! -L ${HOME}/.zshrc ]]; then
          cp -f "${HOME}"/.zshrc "${HOME}"/.zshrc.bak
          echo -e "\tBackup of .zshrc made: ${HOME}/.zshrc.bak "
        fi
        ln -snf "${PWD}"/zsh/zshrc "${HOME}"/.zshrc
        echo -e "\tSymlinked ${PWD}/zsh/zshrc to ${HOME}/.zshrc"
    else
      echo -e "\tSkipping..."
    fi
  else
    cp "${PWD}"/zsh/zshrc "${HOME}"/.zshrc
    echo -e "\tCopied ${PWD}/zsh/zshrc to ${HOME}/.zshrc"
  fi

  if [[ -f ${HOME}/.zshenv ]]; then
    promptUser "Do you want to overwrite ${HOME}/.zshenv with a symlink?"
    if [[ $? -eq 0 ]]; then
        if [[ ! -L ${HOME}/.zshenv ]]; then
          cp -f "${HOME}"/.zshenv "${HOME}"/.zshenv.bak
          echo -e "\tBackup of .zshenv made: ${HOME}/.zshenv.bak "
        fi
        ln -snf "${PWD}"/zsh/zshenv "${HOME}"/.zshenv
        echo -e "\tSymlinked ${PWD}/zsh/zshenv to ${HOME}/.zshenv"
    else
      echo -e "\tSkipping..."
    fi
  else
    ln -sn "${PWD}"/zsh/zshenv "${HOME}"/.zshenv
    echo -e "\tSymlinked ${PWD}/zsh/zshenv to ${HOME}/.zshenv"
  fi

  ## Should private aliases file be created
  if [[ ! -f ${ZshCustomDir}/private-aliases.zsh ]]; then
    touch "${ZshCustomDir}"/private-aliases.zsh
    echo -e "Created ${ZshCustomDir}/private-aliases.zsh to maintain aliases custom to this machine"
  fi
 
  ## Should aliases be symlinked
  if [[ -f ${ZshCustomDir}/aliases.zsh ]]; then
    promptUser "Do you want to overwrite ${ZshCustomDir}/aliases.zsh with a symlink?"
    if [[ $? -eq 0 ]]; then
        ln -snf "${PWD}"/zsh/aliases.zsh "${ZshCustomDir}"/aliases.zsh
        echo -e "\tSymlinked aliases to ${ZshCustomDir}/aliases.zsh"
    else
      echo -e "\tSkipping..."
    fi
  else
    ln -snf "${PWD}"/zsh/aliases.zsh "${ZshCustomDir}"/aliases.zsh
    echo -e "\tSymlinked aliases to ${ZshCustomDir}/aliases.zsh"
  fi

  ## Should functions be symlinked
  if [[ -f ${ZshCustomDir}/functions.zsh ]]; then
    promptUser "Do you want to overwrite ${ZshCustomDir}/functions.zsh with a symlink?"
    if [[ $? -eq 0 ]]; then
        ln -snf "${PWD}"/zsh/functions.zsh "${ZshCustomDir}"/functions.zsh
        echo -e "\tSymlinked functions to ${ZshCustomDir}/functions.zsh"
    else
      echo -e "\tSkipping..."
    fi
  else
    ln -snf "${PWD}"/zsh/functions.zsh "${ZshCustomDir}"/functions.zsh
    echo -e "\tSymlinked functions to ${ZshCustomDir}/functions.zsh"
  fi

  ## Should themes be copied over
  promptUser "Do you want to copy all themes with a symlink?"
  if [[ $? -eq 0 ]]; then
    ln -snf "${PWD}"/zsh/themes/* "${ZshCustomDir}/themes"
    echo -e "\tSymlinked individual themes to ${ZshCustomDir}/themes"
  else
    echo -e "\tSkipping..."
  fi
else
  echo -e "\tSkipping..."
fi

echo -e "\nInstallation of ZSH and Oh-My-Zsh is complete. Please restart your terminals for changes to take effect."
exit

# Ask to setup global env vars aka "dev dir" which will support a function to trigger an update of these dotfiles