# shell-setup

## USAGE
Add to shell profile:

```sh
export PERSONAL_SHELL_SETUP_PATH=<path-to-this-dir>
source $PERSONAL_SHELL_SETUP_PATH/_index.sh
```

For zsh, put this right before the following call:

```sh
export MACHINE_TYPE=work # or: home
source $ZSH/oh-my-zsh.sh
```