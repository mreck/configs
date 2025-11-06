#!/bin/sh
(
	set -e

	wd="$(dirname "$(realpath "$0")")/home"
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
