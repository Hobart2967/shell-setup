#!/bin/bash
if [ ! -d "$HOME/.asdf" ]; then
  printf "\n\n\t$COLORS_BLUE =>$COLORS_GREEN Asdf Version Manager$COLORS_BLUE was not installed yet.$COLORS_GREEN Install it?$COLORS_BLUE (y[es]/n[o]) [Default: n]$COLORS_RESET "
  read yn
  if [[ "$yn" == "y" ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
  fi
fi

ASDF_PREFIX=$(brew --prefix asdf 2> /dev/null)
ASDF_EXISTS=$?
if [[ "$ASDF_EXISTS" == "0" ]]; then
  export ASDF_DATA_DIR="$HOME/.asdf"
  source $ASDF_PREFIX/libexec/asdf.sh
  . ~/.asdf/plugins/java/set-java-home.zsh
fi