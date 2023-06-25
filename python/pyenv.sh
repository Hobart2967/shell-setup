export PYENV_ROOT="$HOME/.pyenv"
PYENV_RESULT=$(command -v pyenv)
if [ ! -z "$PYENV_RESULT" ]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
else
  echo "PyEnv Not installed. Skipping initialization. Install it using 'curl https://pyenv.run | bash'"
fi
