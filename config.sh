#!/bin/sh

set -e

create_symlink() {
	SRC="$(realpath "$1")"
	DST="$2"
	if [ -e "$DST" ]; then
		if [ -L "$DST" ]; then
			printf "[*] deleting old config link: "
			rm -v "$DST"
		else
			printf "[*] backing up old config: "
			mv -v "$DST" "$DST.bak_$(date +%s)"
		fi
	fi
	printf "[*] creating new config link: "
	ln -sv "$SRC" "$DST"
}

create_symlink_if_executable() {
	if [ -x "$(which "$1")" ]; then
		create_symlink "$2" "$3"
	fi
}

touch_if_not_exists() {
	if [ ! -f "$1" ]; then
		touch "$1"
	fi
}

create_symlink_if_executable "tmux" ".tmux.conf" "$HOME/.tmux.conf"
create_symlink_if_executable "vim"  ".vimrc"     "$HOME/.vimrc"
create_symlink_if_executable "zsh"  ".zshrc"     "$HOME/.zshrc"
create_symlink_if_executable "git"  ".gitconfig" "$HOME/.gitconfig"

touch_if_not_exists "$HOME/.gitconfig.local"
touch_if_not_exists "$HOME/.zshrc.local"
