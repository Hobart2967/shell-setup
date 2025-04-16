
CLEANED_OSTYPE="${OSTYPE:0:6}"

if [[ "$CLEANED_OSTYPE" == "darwin" ]]; then
  function godot() {
    echo "Running $GODOT_HOME/Contents/MacOS/Godot $*"
    $GODOT_HOME/Contents/MacOS/Godot $*
  }
fi