#!/bin/sh

alias cd..="cd .."
alias cdtmp='cd "$(mktemp -d)"'

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
