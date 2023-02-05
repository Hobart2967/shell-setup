#!/bin/sh
alias cd_old=cd
nodePath=$(command -v node)

function checkrepo() {
  if [ ! -z "$nodePath" ]; then
    node $PERSONAL_SHELL_SETUP_PATH/git/_index.js $1
  fi
  cd_old $*
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
