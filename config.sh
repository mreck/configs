#!/bin/sh
(
	set -e

	wd="$(dirname "$(realpath "$0")")/home"
	cd "$wd"

	files="$(find ./ -type f -printf '%P\n')"

	for f in $files; do
		dstf="$HOME/$f"
		dstd="$(dirname "$dstf")"
		srcf="$wd/$f"

		mkdir -p "$dstd"

		if [ -L "$dstf" ]; then
			ln -svf "$srcf" "$dstf"
		elif [ ! -e "$dstf" ]; then
			ln -sv "$srcf" "$dstf"
		fi
	done
)
