adb-forward() {
  PORT=$1

  adb reverse tcp:$PORT tcp:$PORT
}