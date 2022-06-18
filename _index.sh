#!/bin/bash

################################################################
## USAGE:                                                     ##
##                                                            ##
## -> Add to shell profile:                                   ##
##      export PERSONAL_SHELL_SETUP_PATH=<path-to-this-dir>   ##
##      . source $PERSONAL_SHELL_SETUP_PATH/_index.sh         ##
################################################################

source $PERSONAL_SHELL_SETUP_PATH/_colors.sh

source $PERSONAL_SHELL_SETUP_PATH/greet.sh

printf "\t Zsh..."
source $PERSONAL_SHELL_SETUP_PATH/zsh.sh
printf " "
printf "Tooling..."
source $PERSONAL_SHELL_SETUP_PATH/_tooling.sh
printf " "
printf "giti Command..."
source $PERSONAL_SHELL_SETUP_PATH/giti.sh
printf " "
printf "git_branch command..."
source $PERSONAL_SHELL_SETUP_PATH/git_branch.sh
printf " "
printf "Node Version Manager..."
source $PERSONAL_SHELL_SETUP_PATH/nvm.sh
printf " "
printf "Yarn..."
source $PERSONAL_SHELL_SETUP_PATH/yarn.sh
printf " "
printf "Lerna utilities..."
source $PERSONAL_SHELL_SETUP_PATH/lerna.sh
