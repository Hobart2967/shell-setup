#!/bin/sh
alias cd_old=cd
alias git_old=git
alias code_old=code
nodePath=$(command -v node)

function checkrepo() {
  if [ ! -z "$nodePath" ]; then
    node $PERSONAL_SHELL_SETUP_PATH/git/_index.js $1
  fi
  cd_old $*
}

function checkrepo_code() {
  REPO_ROOT=""
  if [ -d "$1" ]; then
    REPO_ROOT=$(cd_old "$1" && REPO_ROOT=$(git rev-parse --show-toplevel) && echo "$REPO_ROOT")
  elif [ -f "$1" ]; then
    REPO_ROOT=$(cd_old "$(dirname "$1")" && REPO_ROOT=$(git rev-parse --show-toplevel) && echo "$REPO_ROOT")  
  fi
  
  if [ ! -z "$REPO_ROOT" ]; then
    if [ ! -z "$nodePath" ]; then
      node $PERSONAL_SHELL_SETUP_PATH/git/_index.js $REPO_ROOT
    fi    
  fi

  code_old $*
}

function git-memory() {
  if [ ! -z "$nodePath" ]; then
    node $PERSONAL_SHELL_SETUP_PATH/git/_memory.js $1
  fi
}

function git-all() {
  if [ ! -z "$nodePath" ]; then
    node $PERSONAL_SHELL_SETUP_PATH/git/_all.js $*
  fi
}

alias cd=checkrepo
alias code=checkrepo_code

checkrepo $(pwd)

function git-check() {
  if [ ! -z "$nodePath" ]; then
    node $PERSONAL_SHELL_SETUP_PATH/git/_boot.js
  fi
}

alias old_boot=boot
function gitBoot() {
  git-check
  old_boot
}
alias boot=gitBoot
