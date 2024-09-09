#!/bin/sh

## Author  : Rubin Bhandari (rubiin)
## Mail    : roobin.bhandari@gmail.com
## Github  : @rubiin
## Twitter : @RubinCodes

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IFS=$'\n\t'

# Function to ask yes/no question with a default value
ask_yes_no_default() {
    prompt="$1 (Y/n)"
    default="${2:-}"

    read -p "$prompt: " -n 1 answer
    echo

    case "$answer" in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) return "${default:-0}";;
    esac
}

