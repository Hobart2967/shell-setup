. awsume $*

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

AWS_ENDPOINTS=$(node $SCRIPTPATH/get-endpoints.js $1)

while IFS= read -r line; do
  export $line;
done <<< "$AWS_ENDPOINTS"


if [ ! -z "$AWS_ENDPOINTS" ]; then
  export AWS_PROFILE=$AWSUME_PROFILE
fi