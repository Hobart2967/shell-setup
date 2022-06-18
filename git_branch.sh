#!/bin/bash

git_branch () {
  echo $(git rev-parse --abbrev-ref HEAD 2> /dev/null || echo "(no branch info)")
}
