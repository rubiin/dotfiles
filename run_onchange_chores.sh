#!/bin/sh

# Ensure directory exists
CONFIG_DIR="${HOME}/.config"
ZSH_COMPLETIONS_DIR="$CONFIG_DIR/zsh/zcompletions"
mkdir -p "$ZSH_COMPLETIONS_DIR"

echo "Running chezmoi post tasks in parallel..."

parallel ::: \
  "mise install" \
  "mise prune -y" \
  "bat cache --build"

echo "Generating Zsh completions in $ZSH_COMPLETIONS_DIR..."

parallel ::: \
  "npm completion > $ZSH_COMPLETIONS_DIR/_npm" \
  "just --completions zsh > $ZSH_COMPLETIONS_DIR/_just" \
  "gh completion -s zsh > $ZSH_COMPLETIONS_DIR/_gh" \
  "docker completion zsh > $ZSH_COMPLETIONS_DIR/_docker" \
  "mise completion zsh > $ZSH_COMPLETIONS_DIR/_mise" \
  "delta completion zsh > $ZSH_COMPLETIONS_DIR/_delta" \
  "hydectl completion zsh > $ZSH_COMPLETIONS_DIR/_hydectl"

hydectl reload &

notify-send "Chezmoi finished updating dotfiles"
