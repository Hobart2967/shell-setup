#!/bin/bash

git-branch () {
  echo $(git rev-parse --abbrev-ref HEAD 2> /dev/null || echo "(no branch info)")
}
