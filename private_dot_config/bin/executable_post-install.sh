#!/bin/bash

#  Author: Rubin Bhandari <roobin.bhandari@gmail.com>
#  Date: 2024-09-18
#  GitHub: https://github.com/rubiin
#  Twitter: https://twitter.com/RubinCodes




set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IFS=$'\n\t'



# post install and configure everything


echo "Installing python packages"
./python-install.sh

echo "Installing cargo packages"
./cargo-install.sh
