#!/bin/bash
ASDF_PREFIX=$(brew --prefix asdf 2> /dev/null)
ASDF_EXISTS=$?
if [[ "$ASDF_EXISTS" == "0" ]]; then
  export ASDF_DATA_DIR="$ASDF_PREFIX"
  source $ASDF_DATA_DIR/libexec/asdf.sh
  . ~/.asdf/plugins/java/set-java-home.zsh
fi