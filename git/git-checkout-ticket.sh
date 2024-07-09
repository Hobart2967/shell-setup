#/bin/zsh bash
_git_checkout_completions()
{
  if [ -z "$JIRA_TOKEN" ]; then
    echo "Error: No JIRA_TOKEN set"
    exit 1
  fi



  if [ -z "$JIRA_USER" ]; then
    echo "Error: No JIRA_USER set"
    exit 1
  fi

  if [ -z "$JIRA_URL" ]; then
    echo "Error: No JIRA_URL set"
    exit 1
  fi

  if [ -z "$JIRA_JQL" ]; then
    echo "Error: No JIRA_JQL set"
    exit 1
  fi

  TOKEN=$(echo "$JIRA_USER:$JIRA_TOKEN" | tr -d '\n' | base64)
  JQL_ENCODED=$(echo "$JIRA_JQL" | tr -d '\n' | jq -sRr @uri)

  TICKETS=$(curl --silent \
    --location "$JIRA_URL/rest/api/3/search?jql=$JQL_ENCODED" \
    --header "Authorization: Basic $TOKEN")

  ERRORNEOUS=$(echo $TICKETS | jq -r '. | has("errorMessages")')
  if [ "$ERRORNEOUS" = "true" ]; then
    echo "Error: $(echo $TICKETS | jq -r '.errorMessages[]')"
    exit 1
  fi

  for row in $(echo $TICKETS | jq -r '.issues[] | @base64'); do
    NUMBER=$(echo "$row" | base64 --decode | jq -r '.key')
    TYPE=$(echo "$row" | base64 --decode | jq -r '.fields.issuetype.name')
    PROJECT=$(echo "$row" | base64 --decode | jq -r '.fields.project.key')
    PREFIX="feat"

    if [ "$TYPE" = "Bug" ]; then
      PREFIX="fix"
    fi

    if [ "$PREFIX" = "feat" ]; then
      if [ "$PROJECT" = "DEV" ]; then
        PREFIX="chore"
      fi
    fi

    BRANCH_NAME="$PREFIX/$NUMBER"
    #echo "$BRANCH_NAME"
    COMPREPLY+=("$BRANCH_NAME")
  done
}

gitcheckout() {
  BRANCH=$1

  git stash -m "Stashed changes before creating branch $1"
  git checkout master
  git pull
  git checkout -b $BRANCH
}

complete -F _git_checkout_completions gitcheckout