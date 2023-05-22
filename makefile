host := $(shell uname -s)
arch := $(shell uname -p)
ifeq ($(host),Darwin)
	is_linux = 0
else
	is_linux = 1
endif

.PHONY: help apply info install osx-prereqs linux-prereqs init apply

.DEFAULT_GOAL := help

ifeq ($(host),Darwin)
install: osx-prereqs
else
install: linux-prereqs
endif

# This will output the help for each task. This is denoted by the `##` following the target.
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

osx-prereqs:
	@NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@brew install chezmoi bitwarden-cli

linux-prereqs:
	@sudo pacman -Syuq --noconfirm # Update all currently installed packages
	@sudo pacman -Sq --noconfirm --needed base-devel git zsh chezmoi bitwarden-cli openssh # Install bare minimum packages
	@git clone --quiet https://aur.archlinux.org/yay-bin.git # Install yay (AUR helper)
	@# @cd yay-bin && makepkg -si --no-confirm

info: ## Return basic system info
	@echo $(host)
	@echo $(arch)

init: install ## Runs first initilization of dotfiles
	@export BW_SESSION=$$(bw login --raw) && \
		bw sync && \
		reset && \
	  chezmoi init -v && \
	  chezmoi apply -v

apply: ## Apply dotfiles
	@bw sync && \
		reset && \
		chezmoi apply -v

build: Dockerfile ## Build Docker image for testing dotfiles
	docker build -t dotfiles .
	@touch build

test: build ## Test dotfiles in a container
	docker run -it -v "${PWD}:/home/maverick/.local/share/chezmoi" -v "${PWD}/makefile:/home/maverick/makefile" dotfiles /bin/bash
