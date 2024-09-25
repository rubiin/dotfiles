#!/bin/sh

# use this script to perform cleaaning or anything after applying updates

mise install
mise prune
bat cache --build
Hyde reload &
notify-send "Chezmoi finished updatimg dotfiles"
