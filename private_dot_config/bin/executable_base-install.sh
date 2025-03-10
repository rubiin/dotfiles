#!/bin/bash

#  Author: Rubin Bhandari <roobin.bhandari@gmail.com>
#  Date: 2024-09-18
#  GitHub: https://github.com/rubiin
#  Twitter: https://twitter.com/RubinCodes

set -uo pipefail
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

export TMPFILE="$(mktemp)"
sudo true
rate-mirrors --save=$TMPFILE arch --max-delay=43200 &&
	sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup &&
	sudo mv $TMPFILE /etc/pacman.d/mirrorlist

ask_yes_no_default "Do you want to add chaotic aur?" 0 && sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com &&
	sudo pacman-key --lsign-key 3056513887B78AEB &&
	sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' &&
	sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' &&
	echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf &&
	echo -e '[visual-studio-code-insiders]\nServer = https://nihaals.github.io/visual-studio-code-insiders-arch/\nSigLevel = PackageOptional' | sudo tee -a /etc/pacman.conf

ask_yes_no_default "Do you want to refresh the Arch package database?" 0 && yay -Syyu

ask_yes_no_default "Do you want to install base packages?" 0 && yay -S vivaldi chezmoi wezterm

echo "Installing hyperdots"
git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/Hyprdots
cd ~/Hyprdots/Scripts || exit
./install.sh


ask_yes_no_default "Do you want to install oh-my-tmux?" 0 && git clone https://github.com/gpakosz/.tmux.git ~/.config/tmux/oh-my-tmux &&
	ln -s -f ~/.config/tmux/oh-my-tmux/.tmux.conf ~/.config/tmux/tmux.conf

ask_yes_no_default "Do you want to add sudoers file?" 0 && cp ~/sudoers.lecture /etc/ && echo -e "Defaults lecture=always\nDefaults lecture_file=/etc/sudoers.lecture" | sudo tee -a /etc/sudoers && sudo -k

ask_yes_no_default "Do you want to install Docker and Docker Compose?" 0 && yay -S docker docker-compose &&
	sudo groupadd docker && sudo usermod -aG docker $USER &&
	sudo systemctl enable docker.service && sudo systemctl enable containerd.service

ask_yes_no_default "Do you want to install other packages?" 0 && xargs pacman -S --needed --noconfirm < ~/pacman.txt

sudo fc-cache -vf
 
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh 

echo "Installing sheldon for managing zsh and other plugins?"
sudo pacman -S sheldon
sheldon lock --reinstall

echo "export ZDOTDIR=~/.config/zsh" >/etc/zsh/zshenv

echo "installing flatpaks"
flatpak install flathub org.feichtmeier.Musicpod org.nickvision.tubeconverter io.gitlab.theevilskeleton.Upscaler io.github.flattool.Warehouse io.gitlab.adhami3310.Impression

echo "Installing bat themes"
bat cache --build

echo "Setting alacritty"
wget https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info && sudo tic -xe alacritty,alacritty-direct alacritty.info && rm alacritty.info

echo "Setting wezterm"
tempfile=$(mktemp) && curl -o "$tempfile" https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo && tic -x -o "$TERMINFO" "$tempfile" && rm "$tempfile"

sudo systemctl enable bluetooth.service
sudo systemctl restart bluetooth.service

# Sets up python and installs python's dependencies
echo "Setting up python"
yay -S python-pip python-pipx
pipx ensurepath

ask_yes_no_default "Do you want to add and sync command history with atuin?" 0 && /bin/bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)"

echo "Removing orphaned dependencies"
sudo pacman -Qtdq | sudo pacman -Rns -

echo "Installing mise"
yay -S mise-bin
mise install


ask_yes_no_default "Do you want to apply chezmoi configuration?" 0 && chezmoi init --apply rubiin
echo "creating XDG directories"
xdg-user-dirs-update

echo "Completed setup, run python and cargo installations manually"
