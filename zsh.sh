if [[ ! -z "$ZSH" ]]; then

  #########
  # Theme #
  #########

  if [[ ! -f "$ZSH/custom/themes/agnoster-ex.zsh-theme" ]]; then
    echo "$COLORS_YELLOW\t ==> Downloading zsh theme$COLORS_RESET"
    rm -rf ~/source/github.com/Hobart2967/agnoster-ex
    mkdir -p ~/source/github.com/Hobart2967/agnoster-ex
    git clone git@github.com:Hobart2967/agnoster-ex  ~/source/github.com/Hobart2967/agnoster-ex
    cp ~/source/github.com/Hobart2967/agnoster-ex/agnoster-ex.zsh-theme "$ZSH/custom/themes/agnoster-ex.zsh-theme"
  fi

  ##########
  # Config #
  ##########
  ZSH_THEME=agnoster-ex
  DEFAULT_USER="marco"
fi