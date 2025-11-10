#!/bin/sh

set -e

config_dir="$(dirname "$(realpath "$0")")"

if [ "$config_dir" != "$HOME/.dotfiles" ]; then
	echo "ERROR: dotfiles root dir needs to be '$HOME/.dotfiles'"
	exit 1
fi

(
	wd="$config_dir/home"
	cd "$wd"

	files="$(find ./ -type f -printf '%P\n')"

	for f in $files; do
		dst_f="$HOME/$f"
		dst_d="$(dirname "$dst_f")"
		src_f="$wd/$f"

		mkdir -p "$dst_d"

		if [ -L "$dst_f" ]; then
			ln -svf "$src_f" "$dst_f"
		elif [ ! -e "$dst_f" ]; then
			ln -sv "$src_f" "$dst_f"
		else
			echo "WARNING: could not link $f"
		fi
	done
)
