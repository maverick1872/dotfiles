# Maverick1872's Dotfiles

To use these dotfiles the following command will install Chezmoi, and then apply these dotfiles.

```sh
## Install GitHub CLI via your choice of package manager
# sudo pacman -S gh
# brew install gh

## Authenticate to GitHub and ensure SSH key is configured
# gh auth login -p ssh

## Configure GPG Commit signing
# 

## Install chezmoi via your choice of package manager
# sudo pacman -S chezmoi
# brew install chezmoi

## Install bitwarden cli via your choice of package manager
# sudo pacman -S bitwarden-cli
# brew install bitwarden-cli

## Clone this repoo via ssh, run the interactive configuration, then apply the dotfiles
chezmoi init maverick1872 --ssh --apply
```

To leverage chezmoi in an interactive manner one must install the BitWarden CLI, login & unlock their vault, and then sync
it accordingly PRIOR to running `chezmoi init`

## Arch Setup

Display Manager - X11
Window Manager - AwesomeWM
Greeter - SDDM

Files of note to remember:

- `/etc/X11/xorg.conf.d/10-triple-monitors.conf`
- `/etc/sddm.conf.d/default.conf`
- `/usr/share/sddm/scripts/*`
- `/usr/share/xsessions/awesome.desktop`
- `~/.config/X11/*`

## Configure SDDM

The following commands will allow for leveraging the SDDM configuration. I'll be revisiting this determine how I want to
manage this with Chezmoi or some alternative.

```sh
# Apply SDDM configuration
sudo ln -sf "${PWD}"/sddm/sddm.conf /etc/sddm.conf

# Make SDDM themes available
sudo ln -sf "${PWD}"/sddm/themes /usr/share/sddm/themes

# Xsetup for multiscreen configuration
sudo ln -sf "${PWD}"/sddm/Xsetup /usr/share/sddm/scripts/Xsetup
```

## Reference Documentation

- [ZSH Cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet)
- [ZSH Reference Card:](http://www.bash2zsh.com/zsh_refcard/refcard.pdf)
