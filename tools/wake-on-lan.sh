#!/bin/sh
CLEANED_OSTYPE="${OSTYPE:0:6}"

if [[ "$CLEANED_OSTYPE" == "darwin" ]]; then
  alias wakeup-elanor="wakeonlan 00:25:64:DD:D9:6D"
else
  alias wakeup-elanor="etherwake 00:25:64:DD:D9:6D"
fi