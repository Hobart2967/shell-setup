#!/bin/bash

git-root () {
  echo $(git rev-parse --show-toplevel)
}
