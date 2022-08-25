#!/bin/bash
alias lerna-add='lerna add --scope $(jq ".name" -r < package.json)'
alias lerna-exec='lerna exec --scope $(jq ".name" -r < package.json)'
alias lerna-remove='lerna exec --scope $(jq ".name" -r < package.json) -- yarn remove '
