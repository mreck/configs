#!/usr/bin/sh

yes_or_no() {
    while true; do
        read -p "$1 [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
	        *) return 0 ;;
        esac
    done
}
