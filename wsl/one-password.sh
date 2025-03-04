export OP_PATH="/mnt/c/Users/marco/AppData/Local/Microsoft/WinGet/Packages/AgileBits.1Password.CLI_Microsoft.Winget.Source_8wekyb3d8bbwe/op.exe"

if [ ! -f /usr/local/bin/op ]; then
  chmod a+x $PERSONAL_SHELL_SETUP_PATH/wsl/op
  sudo cp $PERSONAL_SHELL_SETUP_PATH/wsl/op /usr/local/bin/op
fi