host := $(shell uname -s)
arch := $(shell uname -p)
ifeq ($(host),Darwin)
	is_linux = 0
else
	is_linux = 1
endif


.DEFAULT_GOAL := help

# This will output the help for each task. This is denoted by the `##` following the target.
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: info
info: ## Return basic system info
	@echo $(host)
	@echo $(arch)

.PHONY: init
init: ## Runs first initilization of dotfiles
ifndef CODESPACES
	@export BW_SESSION=$$(bw login --raw) && \
		bw sync && \
		reset && \
	  chezmoi init -v -S . && \
	  chezmoi apply -v && \
	  echo "Restart your terminal for the changes to take affect"
else
	@chezmoi init -v -S . && \
	  chezmoi apply -v && \
	  echo "Restart your terminal for the changes to take affect"
endif

.PHONY: apply
apply: ## Apply dotfiles
	@bw sync && \
		reset && \
		chezmoi apply -v

build: Dockerfile ## Build Docker image for testing dotfiles
	docker build -t dotfiles .
	@touch build

.PHONY: test
test: build ## Test interactive dotfiles in a container
	docker run -it -v "${PWD}:/home/maverick/dev/dotfiles" -v "${PWD}/makefile:/home/maverick/makefile" dotfiles /bin/bash make init

.PHONY: test-headless
test-headless: build ## Test noninteractive dotfiles in a container
	docker run -it -e CODESPACES=true -v "${PWD}:/home/maverick/dev/dotfiles" -v "${PWD}/makefile:/home/maverick/makefile" dotfiles /bin/bash
