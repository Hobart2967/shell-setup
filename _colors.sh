supports_truecolor() {
  case "$COLORTERM" in
  truecolor|24bit) return 0 ;;
  esac

  case "$TERM" in
  iterm           |\
  tmux-truecolor  |\
  linux-truecolor |\
  xterm-truecolor |\
  screen-truecolor) return 0 ;;
  esac

  return 1
}

if [ -t 1 ]; then
  is_tty() {
    true
  }
else
  is_tty() {
    false
  }
fi

if is_tty; then
  if supports_truecolor; then
    RAINBOW=(
      "$(printf '\033[38;2;255;0;0m')"
      "$(printf '\033[38;2;255;0;0m')"
      "$(printf '\033[38;2;255;97;0m')"
      "$(printf '\033[38;2;255;97;0m')"
      "$(printf '\033[38;2;247;255;0m')"
      "$(printf '\033[38;2;247;255;0m')"
      "$(printf '\033[38;2;0;255;30m')"
      "$(printf '\033[38;2;0;255;30m')"
      "$(printf '\033[38;2;77;0;255m')"
      "$(printf '\033[38;2;77;0;255m')"
      "$(printf '\033[38;2;168;0;255m')"
    )
  else
    RAINBOW=(
      "$(printf '\033[38;5;196m')"
      "$(printf '\033[38;5;196m')"
      "$(printf '\033[38;5;202m')"
      "$(printf '\033[38;5;202m')"
      "$(printf '\033[38;5;226m')"
      "$(printf '\033[38;5;226m')"
      "$(printf '\033[38;5;082m')"
      "$(printf '\033[38;5;082m')"
      "$(printf '\033[38;5;021m')"
      "$(printf '\033[38;5;021m')"
      "$(printf '\033[38;5;093m')"
    )
  fi

  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  BLUE=$(printf '\033[34m')
  BOLD=$(printf '\033[1m')
  RESET=$(printf '\033[0m')
fi

export COLORS_RED=$RED
export COLORS_GREEN=$GREEN
export COLORS_YELLOW=$YELLOW
export COLORS_BLUE=$BLUE
export COLORS_BOLD=$BOLD
export COLORS_RESET=$RESET
export COLORS_RAINBOW=$RAINBOW