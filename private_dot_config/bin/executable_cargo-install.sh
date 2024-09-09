#! /bin/sh

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IFS=$'\n\t'


# installs cargo dependencies
cargo install ttyper ripgrep stylua cargo-update cargo-cache waycorner
cargo install --git https://github.com/loichyan/nerdfix.git
echo 'Cargo Setup Done with all its packages'

