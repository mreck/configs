if [ -d "$HOME/.oh-my-zsh" ]; then
    export ZSH="$HOME/.oh-my-zsh"
    ZSH_THEME="robbyrussell"
    plugins=()
    source $ZSH/oh-my-zsh.sh
fi

autoload -U colors && colors
autoload -Uz compinit && compinit

setopt AUTO_CD
setopt NO_CASE_GLOB
setopt EXTENDED_HISTORY

export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"

export EDITOR=vim
[ -x "$(which nvim)" ] && export EDITOR=nvim

PROMPT="%B%F{green}%n%f %F{magenta}@%f %F{white}%m%f%b "
PROMPT+="%B%F{magenta}:%f %{$fg[cyan]%}%~%b "
PROMPT+="%(?:%{$fg_bold[green]%}> :%{$fg_bold[red]%}> )%{$reset_color%}"

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward

prepend_path_if_exists() {
	[ -d "$1" ] && export PATH="$1:$PATH"
}

prepend_path_if_exists "$HOME/bin"
prepend_path_if_exists "$HOME/.bin"
prepend_path_if_exists "$HOME/.local/bin"
prepend_path_if_exists "$HOME/go/bin"
prepend_path_if_exists "$HOME/.dotfiles/bin"
prepend_path_if_exists "/usr/local/go/bin"
prepend_path_if_exists "/opt/homebrew/bin"
prepend_path_if_exists "/opt/nvim-linux-x86_64/bin"

[ -x "$(which ssh-agent)" ] && eval "$(ssh-agent)" 1>/dev/null
[ -x "$(which zoxide)" ] && eval "$(zoxide init zsh)"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh" || [ -x "$(which fzf)" ] && source <(fzf --zsh)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ "$(uname)" = "Darwin" ] && alias code="open -a 'Visual Studio Code'"

if [ -x "$(which eza)" ]; then
	D="--group-directories-first"
	I="--icons=always"
	alias ls="eza $D $I"
	alias ll="eza $D $I -lh"
	alias la="eza $D $I -a"
	alias l="eza $D $I -lah"
	alias l1="eza $D $I -1"
	alias lg="eza $D $I -lah --git"
	alias lt="eza $I --time=modified -lah"
else
	alias ls="ls --color=auto --group-directories-first"
	alias ll='ls -lh'
	alias la='ls -a'
	alias l="ls -lah"
	alias l1="ls -1"
	alias lt='ls -laht'
	alias ltr='ls -lahtr'
fi

source_file_if_exists() {
	[ -f "$1" ] && source "$1"
}

source_file_if_exists "$HOME/.dotfiles/include/alias.inc"
source_file_if_exists "$HOME/.zshrc.local"

[ ! -z "$VIM_NOTES" ] && alias n="notes"
