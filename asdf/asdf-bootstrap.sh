#!/bin/bash
if [ ! -d "$HOME/.asdf" ]; then
  printf "\n\n\t$COLORS_BLUE =>$COLORS_GREEN Asdf Version Manager$COLORS_BLUE was not installed yet.$COLORS_GREEN Install it?$COLORS_BLUE (y[es]/n[o]) [Default: n]$COLORS_RESET "
  read yn
  if [[ "$yn" == "y" ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
  fi
fi

export ASDF_DATA_DIR="$HOME/.asdf"
CLEANED_OSTYPE="${OSTYPE:0:6}"
if [[ "$CLEANED_OSTYPE" == "darwin" ]]; then
  ASDF_PREFIX=$(brew --prefix asdf 2> /dev/null)
  ASDF_EXISTS=$?
  if [[ "$ASDF_EXISTS" == "0" ]]; then
    . /opt/homebrew/opt/asdf/libexec/asdf.sh
    . ~/.asdf/plugins/java/set-java-home.zsh
  fi
else
  binPath=$(command -v asdf)
  if [ -z "$binPath" ]; then
    if [ -d "$HOME/.asdf" ]; then
      mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
      asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"

      echo "Loading asdf from $ASDF_DATA_DIR/asdf.sh"
      . $ASDF_DATA_DIR/asdf.sh
    fi
  fi
fi
