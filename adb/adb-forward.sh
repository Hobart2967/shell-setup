adb-forward() {
  PORT=$1
  PROTOCOL=$2
  if [ -z "$PROTOCOL" ]; then
    PROTOCOL=tcp
  fi

  adb reverse $PROTOCOL:$PORT $PROTOCOL:$PORT
}