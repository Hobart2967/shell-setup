#!/bin/bash
# script to pull my current public IP address
# and add a rule to my EC2 security group allowing me https access
function allow-ec2-sg-ip() {
  COUNT="$#"
  if [[ $COUNT -lt 2 ]]; then
    echo "Usage: allow-ec2-sg-ip <HOST> <PORT> <PROTOCOL=tcp>"
  else
    SECURITY_GROUP_ID=$1
    PORT=$2
    PROTOCOL=$3
    if [ -z "$PROTOCOL" ]; then
      PROTOCOL=tcp
    fi


    USER=$(whoami)
    HOST=$(hostname)
    DATE=$(date "+%Y+%m%d %H:%M")

    PUBLIC_IP=$(curl -s -4 https://ipinfo.io | jq .ip -r)

    echo "Find existing rule for $USER@HOST"
    RULE_ID=$(aws ec2 describe-security-group-rules --filter '{ "Name": "group-id", "Values": [ "'$JENKINS_SG'" ] }' --query "max(SecurityGroupRules[?Description==\`$USER@$HOST\`].SecurityGroupRuleId)" | sed 's/"//g' )
    if [ "$RULE_ID" = "null" ]; then
      RULE_ID=""
      echo "Cannot find existing rule. Creating..."
    else
      echo "Found existing rule. Updating..."
    fi

    echo "Allowing ${PORT}:${PORT} on EC2 Security Group ${SECURITY_GROUP_ID} for IP ${PUBLIC_IP}/32"
    if [ -z "$RULE_ID" ]; then
      RESULT=$(aws ec2 authorize-security-group-ingress \
          --group-id ${SECURITY_GROUP_ID} \
          --ip-permissions FromPort=${PORT},ToPort=${PORT},IpProtocol=${PROTOCOL},IpRanges="[{CidrIp="${PUBLIC_IP}/32",Description='${USER}@${HOST}'}]")
    else
       RESULT=$(aws ec2 modify-security-group-rules \
        --group-id ${SECURITY_GROUP_ID} \
        --security-group-rules '[{
          "SecurityGroupRuleId": "'$RULE_ID'",
          "SecurityGroupRule": {
            "IpProtocol": "tcp",
            "FromPort": '${PORT}',
            "ToPort": '${PORT}',
            "CidrIpv4": "'${PUBLIC_IP}'/32",
            "Description": "'${USER}'@'${HOST}'"
          }
        }]')
    fi

  fi
}
