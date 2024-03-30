#! /bin/sh

# Sets up python and installs python's dependencies
yay -S python-pip python-pipx
pipx ensurepath
sudo rm /usr/lib/python3.11/EXTERNALLY-MANAGED
pip install konsave instaloader animdl notebook pre-commit
echo 'Python Setup Done with all its packages'

