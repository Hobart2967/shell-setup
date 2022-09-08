#!/bin/bash
if [ -d "$HOME/.local/bin/aws-sso-util" ]; then
  export PATH="$HOME/.local/bin/aws-sso-util:$PATH"
fi