# Maverick1872's Dotfiles #

To use these dotfiles the following command will install Chezmoi, and then apply these dotfiles.
```sh
# Install chezmoi via your choice of package manager
chezmoi init --apply maverick1872
```

To leverage chezmoi in an interactive manner one must install the BitWarden CLI, login & unlock their vault, and then sync
it accordingly PRIOR to running `chezmoi init`

## Configure Shell (ZSH)##
If you would like to setup ZSH, or just try out my configuration you can run `setupShell.sh`.
It will check to see if ZSH is installed, the associated plugins I use, then prompt you if you
would like to apply the custom configurations from this repository. Additionally, if any pre-requisite
to use my configuration is missing, it will prompt you to install it.

## Configure VIM ##

## Configure TMUX ##

## Reference Documentation ##
* [ZSH Cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet)
* [ZSH Reference Card:](http://www.bash2zsh.com/zsh_refcard/refcard.pdf)

