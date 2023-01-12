#!/bin/bash
push-branch() {
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD | tr -d '\n')
  git push -u origin $CURRENT_BRANCH
}