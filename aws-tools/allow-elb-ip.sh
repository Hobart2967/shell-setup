#!/bin/bash
# script to pull my current public IP address
# and add a rule to my ELB Listener allowing me access
function allow-elb-ip() {
  COUNT="$#"
  if [[ $COUNT -lt 3 ]]; then
    echo "Usage: allow-elb-ip <LISTENER_ARN> <TARGET_GROUP_ARN> <TARGET_HOST>"
  else
    ARN=$1
    TARGET_GROUP_ARN=$2
    TARGET_HOST=$3

    USER=$(whoami)
    HOST=$(hostname)
    DATE=$(date "+%Y+%m%d %H:%M")

    PUBLIC_IP=$(curl -s -4 https://ipinfo.io | jq .ip -r)

    echo "Checking for existing rule..."
    RULES=($(aws elbv2 describe-rules --listener-arn $ARN --query "Rules[*].RuleArn" |  sed 's/^[\[]//g' |  sed 's/^\]//g'  |  sed 's/"//g' | tr ',' ' '))
    FOUND_RULE_ARN=""
    for (( c=0; c< ${#RULES[@]}; c++ ))
    do
      RULE_ARN=${RULES[c]}
      if [ -z "$RULE_ARN" ]; then
        continue;
      fi

      NAME=$(aws elbv2 describe-tags --resource-arns ${RULE_ARN} --query "min(TagDescriptions[].Tags[?Key==\`Name\`].Value[])" | sed 's/"//g')
      if [ "$NAME" = "$USER@$HOST" ]; then
        echo "Found rule! $RULE_ARN"
        FOUND_RULE_ARN=$RULE_ARN
      fi
    done

    FINAL_PRIORITY=1
    if [ -z "$FOUND_RULE" ]; then
      echo "Checking for priority..."
      PRIORITIES=($(aws elbv2 describe-rules --listener-arn $ARN --query "Rules[*].Priority" |  sed 's/^[\[]//g' |  sed 's/^\]//g'  |  sed 's/"//g' | tr ',' ' '))
      MAX_PRIORITY=0
      for (( c=0; c< ${#PRIORITIES[@]}; c++ ))
      do
        PRIORITY=${PRIORITIES[c]}
        if [[ -z "$PRIORITY" ]]; then
          continue;
        fi
        if [[ "$PRIORITY" = "default" ]]; then
          continue;
        fi

        if [[ $MAX_PRIORITY -lt $PRIORITY ]]; then
          MAX_PRIORITY=$PRIORITY
        fi
      done

      FINAL_PRIORITY=$(($MAX_PRIORITY + 1))
    fi

    echo "Allowing ${PORT}:${PORT} on ELB Listener $ARN for IP ${PUBLIC_IP}/32"
    ACTION=modify-rule
    if [ -z "$FOUND_RULE_ARN" ]; then
      ACTION="create-rule --listener-arn '$ARN' --priority $FINAL_PRIORITY"
    else
      ACTION="modify-rule --rule-arn '$FOUND_RULE_ARN'"
    fi

    echo "\n===> CONDITIONS:"
    echo "[{
        \"Field\": \"host-header\",
        \"Values\": [\"$TARGET_HOST\"]
      }, {
        \"Field\": \"source-ip\",
        \"SourceIpConfig\": {
          \"Values\": [\"$PUBLIC_IP/32\"]
        }
      }]" > /tmp/.elb-rule-conditions.json
    cat /tmp/.elb-rule-conditions.json

    echo "\n===> ACTIONS:"
    echo "[{
        \"Type\": \"forward\",
        \"TargetGroupArn\": \"$TARGET_GROUP_ARN\",
        \"Order\": 1
      }]" > /tmp/.elb-rule-actions.json
    cat /tmp/.elb-rule-actions.json

    if [ -z "$FOUND_RULE_ARN" ]; then
      echo "Adding Rule $USER@$HOST..."
    else
      echo "Modifying Rule $USER@$HOST..."
    fi

    COMMAND="aws elbv2 $ACTION --conditions file:///tmp/.elb-rule-conditions.json --actions file:///tmp/.elb-rule-actions.json --query 'min(Rules[].RuleArn[])'"
    RESULT_ARN=$(sh -c "$COMMAND" | sed 's/"//g')
    if [ -z "$FOUND_RULE_ARN" ]; then
      echo "Adding tag $USER@$HOST for later identification"
      sh -c "aws elbv2 add-tags --resource-arns '$RESULT_ARN' --tags 'Key=Name,Value=$USER@$HOST'"
    fi

    rm -rf /tmp/.elb-rule-actions.json
    rm -rf /tmp/.elb-rule-conditions.json
  fi
}