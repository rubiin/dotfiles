#!/bin/bash

#  Author: Rubin Bhandari <roobin.bhandari@gmail.com>
#  Date: 2024-09-18
#  GitHub: https://github.com/rubiin
#  Twitter: https://twitter.com/RubinCodes

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IFS=$'\n\t'


# installs cargo dependencies
cargo install --git https://github.com/loichyan/nerdfix.git
cargo install --git https://github.com/adaszko/complgen.git
echo 'Cargo Setup Done with all its packages'

