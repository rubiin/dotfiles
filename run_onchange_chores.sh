#!/bin/sh

# use this script to perform cleaaning or anything after applying updates

mise install
mise prune
bat cache --build
hydectl reload &
notify-send "Chezmoi finished updating dotfiles"
