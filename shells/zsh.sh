if [[ ! -z "$ZSH" ]]; then
  ZSH_DIR=$HOME/.oh-my-zsh

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


  ###############
  # Autosuggest #
  ###############
  ZSH_AUTOSUGGEST_DIR="$ZSH_DIR/custom/plugins/zsh-autosuggestions"
  if [ ! -d "$ZSH_AUTOSUGGEST_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_AUTOSUGGEST_DIR
  fi

  ###############
  # AWSume #
  ###############
  ZSH_AWSUME_DIR="$ZSH_DIR/custom/plugins/awsume"
  if [ ! -d "$ZSH_AWSUME_DIR" ]; then
    git clone https://github.com/Sordie/AWSume.git $ZSH_AWSUME_DIR
  fi

  ####################
  # Syntax Highlight #
  ####################
  ZSH_SYNTAX_HL_DIR="$ZSH_DIR/custom/plugins/zsh-syntax-highlighting"
  if [ ! -d "$ZSH_SYNTAX_HL_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HL_DIR
  fi

  ##########
  # Config #
  ##########
  ZSH_THEME=agnoster-ex
  DEFAULT_USER=$(whoami)
  plugins=(aws git history docker-compose docker gh awsume zsh-autosuggestions zsh-syntax-highlighting)
fi

