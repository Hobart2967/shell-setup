#!/bin/bash

################################################################
## USAGE:                                                     ##
##                                                            ##
## -> Add to shell profile:                                   ##
##      export PERSONAL_SHELL_SETUP_PATH=<path-to-this-dir>   ##
##      . source $PERSONAL_SHELL_SETUP_PATH/_index.sh         ##
################################################################

source $PERSONAL_SHELL_SETUP_PATH/utilities/_colors.sh
source $PERSONAL_SHELL_SETUP_PATH/utilities/greet.sh

printf "\t Zsh..."
source $PERSONAL_SHELL_SETUP_PATH/shells/zsh.sh
printf " "
printf "Tooling..."
source $PERSONAL_SHELL_SETUP_PATH/utilities/_tooling.sh
printf " "
printf "Git Extensions..."
source $PERSONAL_SHELL_SETUP_PATH/git/giti.sh
source $PERSONAL_SHELL_SETUP_PATH/git/git_branch.sh
source $PERSONAL_SHELL_SETUP_PATH/git/gh.sh
printf " "
printf "Node Development Extensions..."
source $PERSONAL_SHELL_SETUP_PATH/node/nvm.sh
source $PERSONAL_SHELL_SETUP_PATH/node/yarn.sh
source $PERSONAL_SHELL_SETUP_PATH/node/lerna.sh

if [[ "$OSTYPE" =~ ^darwin.* ]]; then
  printf " "
  printf "MacOS Extensions..."
  source $PERSONAL_SHELL_SETUP_PATH/macos/flushdns.sh
fi


echo ""
echo ""
echo "${COLORS_GREEN}Available extension commands:${COLORS_RESET}"
echo "${COLORS_BLUE}Git>${COLORS_RESET} git-branch\t\t\t\t\tPrints the currently checked out repository branch in the current working directory."
echo "${COLORS_BLUE}Git>${COLORS_RESET} giti <pattern>\t\t\t\tAdd the given pattern to a .gitignore file in the current working directory."
echo "\t\t\t\t\t\tCreates the file if not existing, yet."
echo "${COLORS_BLUE}Git>${COLORS_RESET} gh-pr <reviewer> <branch>\t\t\tCreate Pull-Request for <reviewer> and target <branch>"
echo "${COLORS_BLUE}Git>${COLORS_RESET} gh-release <version>\t\t\tCreate a new Release with the specified <version> number as tag label"
echo "____"
echo "${COLORS_BLUE}Node>${COLORS_RESET} nvm\t\t\t\t\tNode version manager."
echo "${COLORS_BLUE}Node>${COLORS_RESET} lerna-add <...args>\t\t\tAdd the requested packages to the lerna package residing in the current folder."
echo "${COLORS_BLUE}Node>${COLORS_RESET} lerna-remove <...args>\t\t\tRemove the requested packages from the lerna package residing in the current folder."
echo "${COLORS_BLUE}Node>${COLORS_RESET} lerna-exec <...args>\t\t\tExecute the command for the lerna package residing in the current folder."
echo "____"
echo "${COLORS_BLUE}MacOS>${COLORS_RESET} flushdns\t\t\t\t\tClears DNS cache in mDNS."
echo ""