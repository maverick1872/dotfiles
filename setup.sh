#!/usr/bin/env bash
. ./setupScripts/helpers.sh

echo "===== Shell configuration ====="
promptUser "Do you wish to configure your shell?"
if [[ $? -eq 0 ]]; then
    ./setupScripts/shell.sh
else
    echo -e "Skipping...\n"
fi


echo -e "===== Git Globals configuration ====="
#TODO: Run a diff against git config if it already exists.
promptUser "Do you wish to configure GIT user globals?"
if [[ $? -eq 0 ]]; then
    cp "${PWD}"/git/config "${HOME}"/.gitconfig
    echo "Copied git user globals to ${HOME}/.gitconfig"
else
    echo -e "Skipping...\n"
fi

#TODO: Add setup steps for vim/tmux/screen when desired
echo -e "===== SDDM configuration ====="
promptUser "Do you wish to configure SDDM?"
if [[ $? -eq 0 ]]; then
    ./setupScripts/sddm.sh
else
    echo -e "Skipping...\n"
fi