if [ ! -f /usr/local/bin/op ]; then
  chmod a+x $PERSONAL_SHELL_SETUP_PATH/wsl/op
  sudo cp $PERSONAL_SHELL_SETUP_PATH/wsl/op /usr/local/bin/op
fi