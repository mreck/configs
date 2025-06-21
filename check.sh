#!/bin/sh

check_exec() {
    if [ ! -x "$(which $1)" ]; then
        echo "[*] Executable not found: $1"
    fi
}

check_exec fzf
check_exec nvim
check_exec tmux
