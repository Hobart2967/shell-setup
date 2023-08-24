#!/bin/bash
# script to pull my current public IP address
# and add a rule to my EC2 security group allowing me https access
function allow-ec2-sg-ip() {
  COUNT="$#"
  if [[ $COUNT -lt 2 ]]; then
    echo "Usage: allow-ec2-sg-ip <HOST> <PORT>"
  else
    SECURITY_GROUP_ID=$1
    PORT=$2

    USER=$(whoami)
    HOST=$(hostname)
    DATE=$(date "+%Y+%m%d %H:%M")

    PUBLIC_IP=$(curl -s -4 https://ipinfo.io | jq .ip -r)

    echo "Allowing ${PORT}:${PORT} on EC2 Security Group ${SECURITY_GROUP_ID} for IP ${PUBLIC_IP}/32"

    aws ec2 authorize-security-group-ingress \
        --group-id ${SECURITY_GROUP_ID} \
        --ip-permissions FromPort=${PORT},ToPort=443,IpProtocol=tcp,IpRanges="[{CidrIp="${PUBLIC_IP}/32",Description='${USER}@${HOST} at ${DATE}'}]"
  fi
}
