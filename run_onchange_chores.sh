#!/bin/sh

# use this script to perform cleaaning or anything after applying updates

mise install
mise prune -y
bat cache --build
hydectl reload &

# Set your completions folder
CONFIG_DIR="${HOME}/.config"
ZSH_COMPLETIONS_DIR="$CONFIG_DIR/zsh/zcompletions"


echo "Generating Zsh completions in $ZSH_COMPLETIONS_DIR..."
npm completion >"$ZSH_COMPLETIONS_DIR/_npm"
just --zsh-completion >"$ZSH_COMPLETIONS_DIR/_just"
gh completion -s zsh >"$ZSH_COMPLETIONS_DIR/_gh"
docker completion zsh >"$ZSH_COMPLETIONS_DIR/_docker"
docker completion zsh >"$ZSH_COMPLETIONS_DIR/_docker"
bat --completion zsh > "$ZSH_COMPLETIONS_DIR/_bat"

notify-send "Chezmoi finished updating dotfiles"
