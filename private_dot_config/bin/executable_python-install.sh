#! /bin/sh

set -e
set -u
# Sets up python and installs python's dependencies
mkdir ~/python3
cd ~/pythton3
python -m ven venv
source venv/bin/activate
yay -S python-pip python-pipx
pipx ensurepath
pip install konsave instaloader animdl notebook pre-commit
echo 'Python Setup Done with all its packages'

