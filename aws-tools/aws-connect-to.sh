#!/bin/bash
# script to pull my current public IP address
# and add a rule to my ELB Listener allowing me access
function aws-connect-to() {
  COUNT="$#"
  if [[ $COUNT -lt 1 ]]; then
    echo "Usage: aws-connect-to <INSTANCE_ID>"
  else
    INSTANCE_ID=$1

    aws ssm start-session --target $INSTANCE_ID
  fi
}