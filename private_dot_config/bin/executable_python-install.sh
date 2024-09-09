#! /bin/sh

set -e
set -u
# Sets up python and installs python's dependencies
yay -S python-pip python-pipx
pipx ensurepath
sudo rm /usr/lib/python3.12/EXTERNALLY-MANAGED
pip install konsave instaloader animdl notebook pre-commit
echo 'Python Setup Done with all its packages'

