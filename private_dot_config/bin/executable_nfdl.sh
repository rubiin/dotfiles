#!/bin/bash

#  Author: Rubin Bhandari <roobin.bhandari@gmail.com>
#  Date: 2024-09-18
#  GitHub: https://github.com/rubiin
#  Twitter: https://twitter.com/RubinCodes



# Define the base URL for the Nerd Fonts releases
BASE_NERD_FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download"

# Define the directory to download and extract the fonts
DOWNLOAD_DIR="$HOME/nerd-fonts"

# Create the download directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Function to show the menu
select_fonts() {
  local fonts=$(whiptail --title "🚀 Nerd Fonts Selection" --checklist \
    "Choose Nerd Fonts to download:" 0 0 0 \
    "DroidSansMono" "Droid Sans Mono" OFF \
    "FiraCode" "Fira Code" OFF \
    "Hack" "Hack" OFF \
    "Inconsolata" "Inconsolata" OFF \
    "UbuntuMono" "Ubuntu Mono" OFF \
    "SourceCodePro" "Source Code Pro" OFF \
    "CascadiaCode" "Cascadia Code" OFF \
    "FantasqueSansMono" "Fantasque Sans Mono" OFF \
    "JetBrainsMono" "JetBrains Mono" OFF \
    "Meslo" "Meslo" OFF \
    "Mononoki" "Mononoki" OFF \
    "RobotoMono" "Roboto Mono" OFF \
    "3270NerdFont" "3270 Nerd Font" OFF \
    "Agave" "Agave" OFF \
    "AnonymiceProNerdFont" "Anonymice Pro Nerd Font" OFF \
    "Arimo" "Arimo" OFF \
    "AurulentSansMonoNerdFont" "Aurulent Sans Mono Nerd Font" OFF \
    "BigBlueTerminal" "BigBlueTerminal" OFF \
    "BitstromWeraNerdFont" "Bitstrom Wera Nerd Font" OFF \
    "BlexMono" "Blex Mono" OFF \
    "CodeNewRomanNerdFont" "Code New Roman Nerd Font" OFF \
    "ComicShannsMonoNerdFont" "Comic Shanns Mono Nerd Font" OFF \
    "CommitMonoNerdFont" "Commit Mono Nerd Font" OFF \
    "CousineNerdFont" "Cousine Nerd Font" OFF \
    "D2Coding" "D2Coding" OFF \
    "DaddyTimeMono" "DaddyTimeMono" OFF \
    "DejaVuSansMonoNerdFont" "DejaVu Sans Mono Nerd Font" OFF \
    "EnvyCodeRNerdFont" "Envy Code R Nerd Font" OFF \
    "FantasqueSansNerdFont" "Fantasque Sans Nerd Font" OFF \
    "FiraCodeNerdFont" "Fira Code Nerd Font" OFF \
    "FiraMonoNerdFont" "Fira Mono Nerd Font" OFF \
    "GeistMonoNerdFont" "Geist Mono Nerd Font" OFF \
    "GoMonoNerdFont" "Go Mono Nerd Font" OFF \
    "GohuNerdFont" "Gohu Nerd Font" OFF \
    "HackNerdFont" "Hack Nerd Font" OFF \
    "HasklugNerdFont" "Hasklug Nerd Font" OFF \
    "HeavyDataMonoNerdFont" "Heavy Data Mono Nerd Font" OFF \
    "HurmitNerdFont" "Hurmit Nerd Font" OFF \
    "iM-Writing" "iM-Writing" OFF \
    "InconsolataNerdFont" "Inconsolata Nerd Font" OFF \
    "InconsolataGoNerdFont" "Inconsolata Go Nerd Font" OFF \
    "InconsolataLGCNerdFont" "Inconsolata LGC Nerd Font" OFF \
    "IntoneMonoNerdFont" "Intone Mono Nerd Font" OFF \
    "IosevkaNerdFont" "Iosevka Nerd Font" OFF \
    "IosevkaTermNerdFont" "Iosevka Term Nerd Font" OFF \
    "IosevkaTermSlabNerdFont" "Iosevka Term Slab Nerd Font" OFF \
    "JetBrainsMono" "JetBrains Mono" OFF \
    "LektonNerdFont" "Lekton Nerd Font" OFF \
    "LiterationMonoNerdFont" "Literation Mono Nerd Font" OFF \
    "LilexNerdFont" "Lilex Nerd Font" OFF \
    "MesloNerdFont" "Meslo Nerd Font" OFF \
    "MonaspiceNerdFont" "Monaspice Nerd Font" OFF \
    "MonofurNerdFont" "Monofur Nerd Font" OFF \
    "MonoidNerdFont" "Monoid Nerd Font" OFF \
    "MononokiNerdFont" "Mononoki Nerd Font" OFF \
    "MPlusNerdFont" "M+ (MPlus) Nerd Font" OFF \
    "Noto" "Noto" OFF \
    "OpenDyslexic" "OpenDyslexic" OFF \
    "Overpass" "Overpass" OFF \
    "ProFontWindowsTweakedNerdFont" "ProFont (Windows tweaked) Nerd Font" OFF \
    "ProFontx11NerdFont" "ProFont (x11) Nerd Font" OFF \
    "ProggyCleanNerdFont" "ProggyClean Nerd Font" OFF \
    "RobotoMono" "Roboto Mono" OFF \
    "SauceCodeNerdFont" "Sauce Code Nerd Font" OFF \
    "ShureTechMonoNerdFont" "Shure Tech Mono Nerd Font" OFF \
    "SpaceMonoNerdFont" "Space Mono Nerd Font" OFF \
    "TerminessNerdFont" "Terminess Nerd Font" OFF \
    "Tinos" "Tinos" OFF \
    "UbuntuNerdFont" "Ubuntu Nerd Font" OFF \
    "UbuntuMonoNerdFont" "Ubuntu Mono Nerd Font" OFF \
    "VictorMono" "Victor Mono" OFF)

  # Check if the user pressed Cancel
  local exit_status=$?
  echo "Exit Status: $exit_status"

  if [ $exit_status -eq 0 ]; then
    selected_fonts=($fonts)
    download_fonts
  else
    echo "🙁 Font selection canceled."
  fi
}

# Function to download selected fonts
download_fonts() {
  for font in "${selected_fonts[@]}"; do
    # Remove any quotation marks from the font name
    font_name=$(echo "$font" | sed 's/["'\'']//g')

    # Construct the download URL
    font_file="${font_name// /}.zip"
    download_url="$BASE_NERD_FONTS_URL/v3.1.1/$font_file"

    echo "🌐 Downloading $font_name..."
    curl -L -o "$DOWNLOAD_DIR/$font_file" "$download_url"

    # Check if the download was successful
    if [ $? -eq 0 ]; then
      # Extract the downloaded zip file and remove any quotation marks from the directory name
      extracted_dir=$(unzip -Z1 "$DOWNLOAD_DIR/$font_file" | head -n1 | sed 's@/$@@')
      echo "🚀 Extracting $font_name..."
      unzip -o "$DOWNLOAD_DIR/$font_file" -d "$DOWNLOAD_DIR"

      # Remove any quotation marks from the directory name
      new_dir=$(echo "$DOWNLOAD_DIR/$extracted_dir" | sed 's/["'\'']//g')
      mv "$DOWNLOAD_DIR/$extracted_dir" "$new_dir"

      # Clean up the zip file
      rm "$DOWNLOAD_DIR/$font_file"
    else
      echo "❌ Failed to download $font_name. Please check your internet connection."
    fi
  done

  echo "✅ Nerd Fonts successfully downloaded and extracted to $DOWNLOAD_DIR"
}

# Run the font selection menu
select_fonts
