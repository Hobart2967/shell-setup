#!/bin/sh

if [[ "$OSTYPE" =~ ^darwin.* ]]; then
  alias wakeup-elanor="wakeonlan 00:2564:DD:D9:6D"
else
  alias wakeup-elanor="etherwake 00:2564:DD:D9:6D"
fi