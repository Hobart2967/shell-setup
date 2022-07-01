#!/bin/bash
gh-pr() {
  URL=$(gh pr create -f -r $1 -B $2)
  echo $URL | pbcopy
  echo $URL
  echo "Copied PR URL to Clipboard!"
}

gh-release() {
  gh release create $1 -t "$1" -n "$1"
}
