#!/usr/bin/env 


set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IFS=$'\n\t'



# post install and configure everything


echo "Installing python packages"
./python-install.sh

echo "Installing cargo packages"
./cargo-install.sh
