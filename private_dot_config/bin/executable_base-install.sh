#!/bin/bash

#  Author: Rubin Bhandari <roobin.bhandari@gmail.com>
#  Date: 2024-09-18
#  GitHub: https://github.com/rubiin
#  Twitter: https://twitter.com/RubinCodes

set -euo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IFS=$'\n\t'

# Function to ask yes/no question with a default value
ask_yes_no_default() {
	prompt="$1 (Y/n)"
	default="${2:-}"

	read -p "$prompt: " -n 1 answer
	echo

	case "$answer" in
	[Yy]*) return 0 ;;
	[Nn]*) return 1 ;;
	*) return "${default:-0}" ;;
	esac
}

ask_yes_no_default "📦 Do you want to install base packages?" 0 && yay -S vivaldi chezmoi wezterm rate-mirrors

echo "🔧 Initializing chezmoi..."
chezmoi init --apply rubiin

export TMPFILE="$(mktemp)"
sudo true
rate-mirrors --save="$TMPFILE" arch --max-delay=43200 &&
	sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup &&
	sudo mv "$TMPFILE" /etc/pacman.d/mirrorlist

ask_yes_no_default "🌩️  Do you want to add chaotic aur?" 0 && sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com &&
	sudo pacman-key --lsign-key 3056513887B78AEB &&
	sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' &&
	sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

echo "⚙️  Setting up pacman"
sudo cp ~/.config/pacman/pacman.conf /etc/pacman.conf
sudo cp ~/.config/pacman-contrib /etc/conf.d/

echo "🪝 Setting up pacman hooks"
sudo mkdir -p /etc/pacman.d/hooks
sudo cp ~/.config/pacman/hooks/* /etc/pacman.d/hooks/
sudo systemctl enable --now paccache.timer

ask_yes_no_default "🔄 Do you want to refresh the Arch package database?" 0 && yay -Syyu

ask_yes_no_default "👤 Do you want to add sudoers file?" 0 && sudo cp ~/sudoers.lecture /etc/ && echo -e "Defaults lecture=always\nDefaults lecture_file=/etc/sudoers.lecture" | sudo tee -a /etc/sudoers && sudo -k

ask_yes_no_default "🐋 Do you want to install Docker and Docker Compose?" 0 && yay -s docker docker-compose &&
	sudo groupadd -f docker &&
	sudo usermod -aG docker $USER &&
	sudo systemctl enable --now docker.service &&
	sudo systemctl enable --now containerd.service &&
	echo
echo "✅ Docker installed successfully."
echo "⚠️  You must log out and log back in (or run 'newgrp docker')"
echo "   for Docker permissions to take effect."
echo
echo "🧪 Test with: docker run hello-world"

# Prevent Docker from preventing boot for network-online.target
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/no-block-boot.conf <<'EOF'
[Unit]
DefaultDependencies=no
EOF

sudo systemctl daemon-reload

echo "🔐 Setting ssh"
mkdir -p ~/.ssh/control
chmod 700 ~/.ssh/control

ask_yes_no_default "📥 Do you want to install other packages?" 0 && xargs pacman -S --needed --noconfirm <~/.config/pacman/pkglist-pacman.txt
ask_yes_no_default "🔱 Do you want to install other AUR packages?" 0 && xargs yay -S --needed --noconfirm <~/.config/pacman/pkglist-aur.txt

echo "🔤 Building font cache..."
sudo fc-cache -vf

echo "🎵 Installing Spicetify marketplace..."
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh

echo "⏱️  Setting up wakatime..."
mkdir "$XDG_CONFIG_HOME/wakatime"

echo "Enabling fstrimer"
sudo systemctl enable fstrim.timer

echo "🐚 Configuring zsh environment..."
echo "export ZDOTDIR=~/.config/zsh" | sudo tee /etc/zsh/zshenv >/dev/null

echo "📦 Installing sheldon for managing zsh and other plugins?"
sudo pacman -S sheldon
sheldon lock --reinstall

echo "📱 Installing flatpaks"
flatpak install flathub org.feichtmeier.Musicpod org.nickvision.tubeconverter io.gitlab.theevilskeleton.Upscaler io.github.flattool.Warehouse

echo "🎨 Installing bat themes"
bat cache --build

echo "🚀 Installing yazi plugins"
ya pkg upgrade

echo "🎨 Setting alacritty"
wget https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info && sudo tic -xe alacritty,alacritty-direct alacritty.info && rm alacritty.info

echo "🎨 Setting wezterm"
tempfile=$(mktemp) && curl -o "$tempfile" https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo && tic -x -o "$TERMINFO" "$tempfile" && rm "$tempfile"

echo "🔵 Enabling bluetooth service"
sudo systemctl enable bluetooth.service
sudo systemctl restart bluetooth.service

# Sets up python and installs python's dependencies
echo "🐍 Setting up python"
yay -S python-pip python-pipx
pipx ensurepath

echo "🔐 Setting gpg"
mkdir -p ~/.local/share/gpg
chmod 700 ~/.local/share/gpg

echo "🧹 Removing orphaned dependencies"
sudo pacman -Qtdq | sudo pacman -Rns -

echo "⚡ Installing mise"
curl https://mise.run | sh
mise install

echo "🟩 Setting tmux"
curl -fsSL "https://github.com/gpakosz/.tmux/raw/refs/heads/master/install.sh#$(date +%s)" | bash

ask_yes_no_default "🔄 Do you want to reapply chezmoi configuration (recommended)?" 0 && chezmoi apply

echo "📁 Creating XDG directories"
xdg-user-dirs-update

echo "✅ Completed setup! Please restart your terminal and log out and log back in for all changes to take effect."
