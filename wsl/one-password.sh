export WIN_USER_PROFILE=$(wslpath "$(cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r')")

if [ ! -f /usr/local/bin/op ]; then
  chmod a+x $PERSONAL_SHELL_SETUP_PATH/wsl/op
  sudo cp $PERSONAL_SHELL_SETUP_PATH/wsl/op /usr/local/bin/op
fi

export SSH_AUTH_SOCK=$HOME/.1password/agent.sock
if ! pgrep -f "socat.*agent.sock" >/dev/null; then
  NPIPE_RELAY=$(ls "$WIN_USER_PROFILE"/AppData/Local/Microsoft/WinGet/Packages/jstarks.npiperelay_*/npiperelay.exe 2>/dev/null | head -n1)
  if [ -z "$NPIPE_RELAY" ]; then
    echo "npiperelay.exe not found" >&2
  else
    mkdir -p "$HOME/.local/bin" "$(dirname "$SSH_AUTH_SOCK")"
    ln -sf "$NPIPE_RELAY" "$HOME/.local/bin/npiperelay.exe"
    rm -f "$SSH_AUTH_SOCK"
    (setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork \
      EXEC:"$HOME/.local/bin/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
  fi
fi