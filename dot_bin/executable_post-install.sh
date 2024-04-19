#!/usr/bin/env 


# post install and configure everything

echo "Downloading wallpapers"
./wallpaper.sh

echo "Installing python packages"
./python-install.sh

echo "Installing cargo packages"
./cargo-install.sh
