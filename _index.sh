#!/bin/bash

################################################################
## USAGE:                                                     ##
##                                                            ##
## -> Add to shell profile:                                   ##
##      export PERSONAL_SHELL_SETUP_PATH=<path-to-this-dir>   ##
##      . source $PERSONAL_SHELL_SETUP_PATH/_index.sh         ##
################################################################
alias boot=echo ""

if [ -f "$HOME/.env" ]; then
  set -o allexport; source $HOME/.env; set +o allexport
fi

export MICROSOFT_UNAME=$(uname -a | grep -i microsoft)
export IS_WSL=$( [ ! -z "$MICROSOFT_UNAME" ] && echo "1" || echo "0" )

source $PERSONAL_SHELL_SETUP_PATH/utilities/_colors.sh
source $PERSONAL_SHELL_SETUP_PATH/utilities/greet.sh

printf "\t Zsh..."
source $PERSONAL_SHELL_SETUP_PATH/shells/zsh.sh
printf " "

printf "Tooling..."
source $PERSONAL_SHELL_SETUP_PATH/utilities/_tooling.sh
source $PERSONAL_SHELL_SETUP_PATH/adb/adb-forward.sh
printf " "

printf "AWS Tooling..."
source $PERSONAL_SHELL_SETUP_PATH/aws-tools/awsume.sh
source $PERSONAL_SHELL_SETUP_PATH/aws-tools/allow-ec2-sg-ip.sh
source $PERSONAL_SHELL_SETUP_PATH/aws-tools/allow-elb-ip.sh
source $PERSONAL_SHELL_SETUP_PATH/aws-tools/sso-creds.sh
source $PERSONAL_SHELL_SETUP_PATH/aws-tools/aws-connect-to.sh

printf "Python Tooling..."
source $PERSONAL_SHELL_SETUP_PATH/python/pyenv.sh

printf "Git Extensions..."
source $PERSONAL_SHELL_SETUP_PATH/git/_index.sh
source $PERSONAL_SHELL_SETUP_PATH/git/giti.sh
source $PERSONAL_SHELL_SETUP_PATH/git/git_branch.sh
source $PERSONAL_SHELL_SETUP_PATH/git/git-root.sh
source $PERSONAL_SHELL_SETUP_PATH/git/push-branch.sh
source $PERSONAL_SHELL_SETUP_PATH/git/create-patch.sh
source $PERSONAL_SHELL_SETUP_PATH/git/apply-patch.sh
source $PERSONAL_SHELL_SETUP_PATH/git/gh.sh
printf " "
echo "$COLORS_RESET"

printf "Node Development Extensions..."
source $PERSONAL_SHELL_SETUP_PATH/node/nvm.sh
source $PERSONAL_SHELL_SETUP_PATH/node/yarn.sh
source $PERSONAL_SHELL_SETUP_PATH/node/lerna.sh
source $PERSONAL_SHELL_SETUP_PATH/sls/sls.sh

printf "Asdf Extensions..."
source $PERSONAL_SHELL_SETUP_PATH/asdf/asdf-bootstrap.sh

printf "Tools Extensions..."
source $PERSONAL_SHELL_SETUP_PATH/tools/wake-on-lan.sh
source $PERSONAL_SHELL_SETUP_PATH/tools/one-password.sh

printf "pipx Extensions..."
source $PERSONAL_SHELL_SETUP_PATH/pipx/pipx-path-helper.sh

printf "Java Extensions..."
source $PERSONAL_SHELL_SETUP_PATH/java/jasypt.sh

if [[ "$IS_WSL" == "1" ]]; then
  source $PERSONAL_SHELL_SETUP_PATH/wsl/xdg-open-fix.sh
fi

if [[ ! -z "$SHELL_SETUP_EXTENSION" ]]; then
  source $SHELL_SETUP_EXTENSION
fi

CLEANED_OSTYPE="${OSTYPE:0:6}"

if [[ "$CLEANED_OSTYPE" == "darwin" ]]; then
  printf " "
  printf "MacOS Extensions..."
  source $PERSONAL_SHELL_SETUP_PATH/macos/_init.sh
  source $PERSONAL_SHELL_SETUP_PATH/macos/flushdns.sh
  source $PERSONAL_SHELL_SETUP_PATH/macos/show-frequency.sh
  source $PERSONAL_SHELL_SETUP_PATH/macos/show-temperature.sh

  if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
  fi
fi

echo ""
echo ""
echo "${COLORS_GREEN}Available extension commands:${COLORS_RESET}"
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}git-branch${COLORS_RESET}\t\t\t\t\tPrints the currently checked out repository branch in the current working directory."
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}giti${COLORS_RESET} <pattern>\t\t\t\tAdd the given pattern to a .gitignore file in the current working directory."
echo "\t\t\t\t\t\tCreates the file if not existing, yet."
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}gh-pr${COLORS_RESET} <reviewer> <branch>\t\t\tCreate Pull-Request for <reviewer> and target <branch>"
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}gh-release${COLORS_RESET} <version>\t\t\tCreate a new Release with the specified <version> number as tag label"
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}push-branch${COLORS_RESET} \t\t\t\tPushes the current branch to origin. Creates branch at origin if not existing"
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}create-patch${COLORS_RESET}\t\t\t\tCreates a patch from the last commit."
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}apply-patch${COLORS_RESET} <patchFile>\t\t\tApplies the given patchfile to the current repository."
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}git-memory${COLORS_RESET} [days] [--all]\t\t\tShows commits throughout all repositories for x days."
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}git-all${COLORS_RESET} <command>\t\t\t\tRun git command for all repositories."
echo "${COLORS_BLUE}Git>${COLORS_RESET} ${COLORS_YELLOW}git-check${COLORS_RESET}\t\t\t\t\tCheck all known repositories for changes or commits that have not been pushed to origin yet."
echo "____"
echo "${COLORS_BLUE}Node>${COLORS_RESET} ${COLORS_YELLOW}nvm${COLORS_RESET}\t\t\t\t\tNode version manager."
echo "${COLORS_BLUE}Node>${COLORS_RESET} ${COLORS_YELLOW}lerna-add${COLORS_RESET} <...args>\t\t\tAdd the requested packages to the lerna package residing in the current folder."
echo "${COLORS_BLUE}Node>${COLORS_RESET} ${COLORS_YELLOW}lerna-remove${COLORS_RESET} <...args>\t\t\tRemove the requested packages from the lerna package residing in the current folder."
echo "${COLORS_BLUE}Node>${COLORS_RESET} ${COLORS_YELLOW}lerna-exec${COLORS_RESET} <...args>\t\t\tExecute the command for the lerna package residing in the current folder."
if [[ "$CLEANED_OSTYPE" == "darwin" ]]; then
echo "____"
echo "${COLORS_BLUE}MacOS>${COLORS_RESET} ${COLORS_YELLOW}flushdns${COLORS_RESET}\t\t\t\t\tClears DNS cache in mDNS."
echo "${COLORS_BLUE}MacOS>${COLORS_RESET} ${COLORS_YELLOW}install-pc-keyboard${COLORS_RESET}\t\t\tInstalls Windows (PC) Keyboard layouts for MacOS."
echo "${COLORS_BLUE}MacOS>${COLORS_RESET} ${COLORS_YELLOW}show-frequency${COLORS_RESET}\t\t\t\tShows current CPU and GPU clock"
echo "${COLORS_BLUE}MacOS>${COLORS_RESET} ${COLORS_YELLOW}show-temperature${COLORS_RESET}\t\t\t\tShows current CPU and GPU temperature."
fi
echo ""

source $PERSONAL_SHELL_SETUP_PATH/system.sh

boot