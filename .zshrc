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
export HISTFILE=~/.zsh_history

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

alias e="fuzzy-edit"
alias j="source jmp2dir"

alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias g="git"
alias gs="git status"

alias ga="git add"
alias gaa="git add ."
alias gap="git add -p"

alias gd="git diff"
alias gds="git diff --staged"
alias grs="git restore --staged"

alias gc="git commit"
alias gcm="git commit --message"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"

alias gl="git log"
alias gls="git log --stat"
alias gll="git log --graph --abbrev-commit --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr) %C(bold blue)<%an>%Creset %C(yellow)%d%Creset'"
alias gllom="git log --graph --abbrev-commit --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr) %C(bold blue)<%an>%Creset %C(yellow)%d%Creset' origin/master.."
alias glp="git log --patch"
alias gla="git log --stat --patch"
alias glom="git log origin/master.."
alias glomp="git log --patch origin/master.."
alias gloms="git log --stat origin/master.."
alias gle="git log --pretty=email"

alias gfa="git fetch --all --prune"

alias gp="git push"
alias gpb='gp -u origin `git branch --show-current` --no-verify'
alias gpom="git push -u origin/master"
alias gpfl="git push --force-with-lease"

alias grom="git rebase origin/master --autostash --autosquash"
alias gromi="grom -i"

alias gbpurge='git branch --merged | grep -Ev "(\*|master|develop|staging)" | xargs -n 1 git branch -d'

if [ -x "$(which tmux)" ]; then
	tmux_create_or_attach() {
		if [ -z "$TMUX_DIRS" ]; then
			echo "ERROR: TMUX_DIRS is not set"
			return 1
		fi
		DIR="$(echo $TMUX_DIRS | tr ':' '\n' | xargs -I{} find {} -mindepth 1 -maxdepth 1 -type d | sort | fzf)"
		if [ -z "$DIR" ]; then
			echo "ERROR: no dir selected"
			return 1
		fi
		NAME="$(echo "$DIR" | sed "s|^$HOME|H|" | tr "/" ".")"
		if [ tmux has-session -t "$NAME" ]; then
			tmux attach-session -t "$NAME"
		else
			tmux new-session -c "$DIR" -t "$NAME"
		fi
	}

	alias t=tmux_create_or_attach
fi

upall() {
	if [ "$(uname)" = 'Linux' ] && [ ! -z "$(which apt)" ]; then
		echo "[*] Running apt update..."
		sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
	fi
	if [ "$(uname)" = 'Darwin' ] && [ ! -z "$(which brew)" ]; then
		echo "[*] Running brew update..."
		brew update && brew upgrade
	fi
}

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
[ ! -z "$VIM_NOTES" ] && alias n="notes"
