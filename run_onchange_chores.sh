#!/bin/sh

# use this script to perform cleaaning or anything after applying updates

mise install
mise prune
bat cache --build
Hyde reload &
rm -rf .terminfo
tempfile=$(mktemp) && curl -o "$tempfile" https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo && tic -x -o "$TERMINFO" "$tempfile" && rm "$tempfile"
notify-send "Chezmoi finished updatimg dotfiles"
