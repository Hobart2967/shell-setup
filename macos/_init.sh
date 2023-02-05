install-pc-keyboard() {
  sudo cp -r $PERSONAL_SHELL_SETUP_PATH/macos/keyboard/* /Library/Keyboard\ Layouts/
  sudo mkdir -p /Library/KeyBindings/
  sudo cp $PERSONAL_SHELL_SETUP_PATH/macos/DefaultKeyBinding.Dict /Library/KeyBindings/
}