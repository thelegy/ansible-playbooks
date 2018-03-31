#!/bin/bash


# Configure the path to the underlying binary to use
app_path="${GOPATH:-$HOME/go}/bin/hcloud_inventory"

# Configure the path to the file containing the api token
token_path=".hcloud_token.txt"


exit_early () {
  echo "{}"
  exit
}


call_with_api_token () {
  local token=$(cat "$token_path" 2>&-)
  [ -z "$token" ] && exit_early
  HCLOUD_TOKEN="$token" "$@"
  result=$?
  unset token
  exit $result
}


# Exit early if the specified binary is not found
[ -x "$app_path" ] || exit_early

call_with_api_token "$app_path" "$@"
