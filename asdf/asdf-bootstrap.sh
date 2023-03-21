#!/bin/bash
if [ ! -d "$HOME/.asdf" ]; then
  printf "\n\n\t$COLORS_BLUE =>$COLORS_GREEN Asdf Version Manager$COLORS_BLUE was not installed yet.$COLORS_GREEN Install it?$COLORS_BLUE (y[es]/n[o]) [Default: n]$COLORS_RESET "
  read yn
  if [[ "$yn" == "y" ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
  fi
fi

if [ -d "$HOME/.asdf" ]; then
  #source "/opt/homebrew/opt/asdf/libexec/asdf.sh"
  . ~/.asdf/plugins/java/set-java-home.zsh
fi