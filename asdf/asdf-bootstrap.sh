#!/bin/bash
if [ -d "$HOME/.asdf" ]; then
  #source "/opt/homebrew/opt/asdf/libexec/asdf.sh"
  . ~/.asdf/plugins/java/set-java-home.zsh
fi