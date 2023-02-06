#!/bin/sh
alias cd_old=cd
nodePath=$(command -v node)

function checkrepo() {
  if [ ! -z "$nodePath" ]; then
    node $PERSONAL_SHELL_SETUP_PATH/git/_index.js $1
  fi
  cd_old $*
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
checkrepo $(pwd)

alias old_boot=boot
function gitBoot() {
  if [ ! -z "$nodePath" ]; then
    node $PERSONAL_SHELL_SETUP_PATH/git/_boot.js
  fi

  old_boot
}
alias boot=gitBoot
