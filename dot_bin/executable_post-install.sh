#!/usr/bin/env 


# post install and configure everything


echo "Installing python packages"
./python-install.sh

echo "Installing cargo packages"
./cargo-install.sh
