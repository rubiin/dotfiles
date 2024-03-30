#!/bin/sh

# Function to ask yes/no question with a default value
ask_yes_no_default() {
    local prompt="$1 (Y/n)"
    local default="${2:-}"

    read -p "$prompt: " -n 1 answer
    echo

    case "$answer" in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) return "${default:-0}";;
    esac
}

# Function to parse the .tool-versions file
parse_tools_version() {
    # Define the file path
    local file="$HOME/.tool-versions"

    # Check if the file exists
    if [ -f "$file" ]; then
        # Declare an associative array
        declare -A versions

        # Read each line of the file
        while IFS= read -r line; do
            # Extract tool and version
            local tool=$(echo "$line" | awk '{print $1}')
            local version=$(echo "$line" | awk '{print $2}')

            # Add tool and version to the associative array
            versions["$tool"]="$version"
        done < "$file"

        # Return the associative array
        echo "${versions[@]}"
    else
        echo "File $file not found."
        return 1
    fi
}


tool_versions=$(parse_tools_version)

export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=43200 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist

ask_yes_no_default "Do you want to add chaotic aur?" 0 && sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
    sudo pacman-key --lsign-key 3056513887B78AEB && \
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' && \
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && \
    echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf

ask_yes_no_default "Do you want to refresh the Arch package database?" 0 && yay -Syyu

ask_yes_no_default "Do you want to install base packages?" 0 && yay -S vivaldi chezmoi wezterm

ask_yes_no_default "Do you want to install normal fonts?" 0 && yay -S noto-fonts-cjk noto-fonts-emoji fontforge gnu-free-fonts ttf-joypixels ttf-font-awesome ttf-hack ttf-ms-fonts ttf-twemoji-color ttf-bitstream-vera ttf-cm-unicode

ask_yes_no_default "Do you want to install nerd fonts?" 0 && yay -S ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-dejavu-nerd ttf-hack-nerd

sudo fc-cache -vf

ask_yes_no_default "Do you want to install oh-my-tmux?" 0 && git clone https://github.com/gpakosz/.tmux

ask_yes_no_default "Do you want to install pnpm?" 0 && curl -fsSL https://get.pnpm.io/install.sh | sh -

echo "Setting alacritty"
wget https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info &&  sudo tic -xe alacritty,alacritty-direct alacritty.info && rm alacritty.info

echo "Setting wezterm"
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

ask_yes_no_default "Do you want to install Docker and Docker Compose?" 0 && yay -S docker docker-compose && \
    sudo groupadd docker && sudo usermod -aG docker $USER && \
    sudo systemctl enable docker.service && sudo systemctl enable containerd.service

ask_yes_no_default "Do you want to install other packages?" 0 && yay -S btop words ktouch keybase words cloc gitflow-cjs yt-dlp mongodb-compass zoxide wl-clipboard mkcert p7zip jq entr ripgrep lazydocker-bin stacer plasma-systemmonitor just github-cli postman-bin httpie  mpv ark jetbrains-toolbox tmux lsd thefuck taskwarrior-tui git-delta kcolorchooser grex fd sd tealdeer bat the_silver_searcher git-secrets fzf git-interactive-rebase-tool-bin mousepad nano mojave-gtk-theme-git adwaita-icon-theme capitaine-cursors gparted htop la-capitaine-icon-theme neovim rate-mirrors spectacle vlc youtube-dl gwenview ktorrent persepolis

ask_yes_no_default "Do you want to install Zsh with Oh My Zsh and other plugins?" 0 && \
    sudo pacman -S zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open && \
    git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate && \
    git clone https://github.com/mroth/evalcache ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/evalcache


echo "Installing bat themes"
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes/" https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme
wget -P "$(bat --config-dir)/themes/" https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-frappe.tmTheme
bat cache --build



ask_yes_no_default "Do you want to add plugins for asdf ?" 0 && \
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0 && \
    source ~/.zshrc && \
    asdf update && \
    for plugin in "${!tool_versions[@]}"; do \
        asdf plugin add "$plugin" && \
        asdf install "$plugin" "${tool_versions[$plugin]}" && \
        asdf global "$plugin" "${tool_versions[$plugin]}"; \
    done

ask_yes_no_default "Do you want to install LunarVim?" 0 && \
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh) && \
    yay -Rns kate okular
ask_yes_no_default "Do you want to add and sync command history with atuin?" 0 && sudo pacman -S atuin
ask_yes_no_default "Do you want to remove unused packages?" 0 && sudo pacman -Qtdq | sudo pacman -Rns -

ask_yes_no_default "Do you want to apply chezmoi configuration?" 0 && chezmoi init --apply rubiin
