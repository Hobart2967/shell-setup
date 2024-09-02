VERSION=1.9.3
EXTENSION_ROOT=$PERSONAL_SHELL_SETUP_PATH/java/
if [ ! -d "$EXTENSION_ROOT/dist-jasypt" ]; then
  wget -O $EXTENSION_ROOT/jasypt.zip https://github.com/jasypt/jasypt/releases/download/jasypt-$VERSION/jasypt-$VERSION-dist.zip
  rm -rf $EXTENSION_ROOT/dist-jasypt
  unzip $EXTENSION_ROOT/jasypt.zip -d $EXTENSION_ROOT
  mkdir $EXTENSION_ROOT/dist-jasypt
  cp -r $EXTENSION_ROOT/jasypt-*/* $EXTENSION_ROOT/dist-jasypt
  rm -rf $EXTENSION_ROOT/jasypt-*
  rm -rf $EXTENSION_ROOT/jasypt.zip

  echo "Downloaded jasypt, setting execute permissions on binaries"
  chmod u+x "$PERSONAL_SHELL_SETUP_PATH/java/dist-jasypt/bin/encrypt.sh"
  chmod u+x "$PERSONAL_SHELL_SETUP_PATH/java/dist-jasypt/bin/decrypt.sh"
fi


alias jasypt-decrypt="$PERSONAL_SHELL_SETUP_PATH/java/dist-jasypt/bin/decrypt.sh"
alias jasypt-encrypt="$PERSONAL_SHELL_SETUP_PATH/java/dist-jasypt/bin/encrypt.sh"

