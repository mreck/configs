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

export SAVEHIST=1000000
export HISTFILE=~/.zsh_history

export EDITOR=vim

PROMPT="%B%F{green}%n%f %F{magenta}@%f %F{white}%m%f%b "
PROMPT+="%B%F{magenta}:%f %{$fg[cyan]%}%~%b "
PROMPT+="%(?:%{$fg_bold[green]%}> :%{$fg_bold[red]%}> )%{$reset_color%}"

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward

prepend_path_if_exists() {
	if [ -d "$1" ]; then
		export PATH="$1:$PATH"
	fi
}

prepend_path_if_exists "$HOME/bin"
prepend_path_if_exists "$HOME/.bin"
prepend_path_if_exists "$HOME/.local/bin"
prepend_path_if_exists "$HOME/go/bin"
prepend_path_if_exists "/usr/local/go/bin"
prepend_path_if_exists "/opt/homebrew/bin"
prepend_path_if_exists "/opt/nvim-linux-x86_64/bin"

if [ -x "$(which ssh-agent)" ];then
	eval "$(ssh-agent)" 1>/dev/null
fi

if [ -f ~/.fzf.zsh ]; then
	source ~/.fzf.zsh
elif [ -x "$(which fzf)" ]; then
	source <(fzf --zsh)
fi

if [ -x "$(which zoxide)" ]; then
	eval "$(zoxide init zsh)"
fi

if [ "$(uname)" = "Darwin" ]; then
    alias code="open -a 'Visual Studio Code'"
fi

if [ -x "$(which eza)" ];then
	alias eza="eza --group-directories-first --icons=always"
	alias ls="eza"
	alias l="eza -lah"
	alias l1="eza -1"
	alias lg="eza -lah --git"
else
	alias ls="ls --color=auto --group-directories-first"
	alias l="ls -lah"
	alias l1="ls -1"
	alias lt='ls -laht'
	alias ltr='ls -lahtr'
fi

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

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
