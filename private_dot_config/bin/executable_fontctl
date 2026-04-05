#!/bin/bash

set -euo pipefail

# Get the selected font from fzf
selected_font=$(fc-list --format="%{family[0]}\n" | sort | uniq | fzf)

# Print the selected font
echo "Selected font: $selected_font"

# Path to the kitty configuration file
kitty_conf_path="$HOME/.config/kitty/kitty.conf"

# Check if the kitty configuration file exists
if [[ -f "$kitty_conf_path" ]]; then
  # Update the font family in kitty.conf
  sed -i.bak -E "s/^font_family\s+.*$/font_family $selected_font/" "$kitty_conf_path"
  echo "Updated font_family to: $selected_font in $kitty_conf_path"
else
  echo "kitty.conf file does not exist at $kitty_conf_path"
fi
