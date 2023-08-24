#!/bin/bash
gh-pr() {
  URL=$(gh pr create -f -r $1 -B $2)
  echo $URL | pbcopy
  echo $URL
  echo "Copied PR URL to Clipboard!"
}

gh-pra() {
  CMD="gh pr create -f $PR_TEAM_MEMBERS -B $1"
  URL=$($(echo $CMD))
  echo $URL | pbcopy
  echo $URL
  echo "Copied PR URL to Clipboard!"
}

git-update-from() {
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  git stash
  git checkout $1
  git pull
  git checkout $CURRENT_BRANCH
  git merge $1
}

gh-release() {
  gh release create $1 -t "$1" -n "$1"
}

gh-delease() {
  gh release delete $1
  git push --delete origin $1
}
