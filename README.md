# shell-setup

## PRE-REQUISITES

```sh
# Install ZSH on MacOs
brew install zsh

# Install ZSH on debian distros
sudo apt install zsh
```

Then, add oh my zsh:

```sh
# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## USAGE
Add to shell profile (~/.zshrc):

```sh
export PERSONAL_SHELL_SETUP_PATH=<path-to-this-dir>
source $PERSONAL_SHELL_SETUP_PATH/_index.sh
```

For zsh, put this right before the following call:

```sh
export MACHINE_TYPE=work # or: home
source $ZSH/oh-my-zsh.sh
```

## Beauty-Setup

On Windows 10:
```sh
export TMP_DIR=/mnt/c/Temp
mkdir -p $TMP_DIR
curl -L -o $TMP_DIR/powerline.zip https://github.com/powerline/fonts/archive/refs/heads/master.zip
unzip $TMP_DIR/powerline.zip -d  $TMP_DIR/powerline
```

```powershell
Set-ExecutionPolicy RemoteSigned
C:\Temp\powerline\fonts-master\install.ps1
Set-ExecutionPolicy Default
cd
Remove-Item -Recurse -Force C:\Temp\
```

## Environment file

To make the shell setup load an non-version controlled, create a .env file in your home directory:

```sh
AN_ENVIRONMENT_VAR=WITH_VALUE
```

Upon next shell init it will be globally available for your user.

## Install java

asdf plugin add java
asdf install java corretto-11.0.19.7.1