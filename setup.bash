#!/usr/bin/env bash

log_section() {
	printf "\033[1;32m[^] $1\033[0m\n"
}

log_update() {
	printf "\033[0;32m[>] $1\033[0m\n"
}

function yes_or_no {
    while true; do
        read -p "$1 [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
			    *) return 0 ;;
        esac
    done
}

brew_install() {
	log_section "Installing $1"
	if brew list $1 &>/dev/null; then
		log_update "${1} is already installed"
	else
		brew install $1 && echo "$1 is installed"
	fi
}

setup_macos() {
	log_section "Setting up MacOS"
	brew_pkgs=(       \
		curl          \
		eza           \
		ffmpeg        \
		fzf           \
		git           \
		htop          \
		imagemagick   \
		jq            \
		lazygit       \
		mpv           \
		neovim        \
		ripgrep       \
		sqlite        \
		tmux          \
		tree          \
		vlc           \
		wget          \
		zellij        \
		zoxide        \
	)

	log_section "Updating Homebrew packages"

	brew update
	brew upgrade

	for pkg in "${brew_pkgs[@]}"; do
		brew_install $pkg
	done
}

setup_configs() {
	log_section "Updating configs"

	log_section "Updating ZSH config"
	if [ ! -f "$HOME/.zshrc" ] || yes_or_no "override ZSH config? ($HOME/.zshrc)"; then
		wget -O "$HOME/.zshrc" --no-verbose https://reck.cloud/c/.zshrc
		log_update "ZSH config updated"
	else
		log_update "skipped"
	fi
}

[ "$(uname)" = "Darwin" ] && setup_macos
setup_configs
