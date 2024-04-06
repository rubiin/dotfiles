# i3/Linux Config Files (Tokyo Rice)

My config files for various aspects of my (first rice!) set up with i3 on Linux.

Arch users can directly run the install-packages.sh . For other distros, you can view the file and install the dependencies manaully. Also, if you want to get most of the repo, use the first theme as its weekly updated by me (Rubin)

# Things I use 
* Tmux (https://github.com/gpakosz/.tmux)
* Neovim with lazyvim(https://www.lazyvim.org)
* Wezterm/Alacritty
* Zsh with Ohmyzsh (https://ohmyz.sh/#install)
* Plasma Kde5

# Get started
 ```bash
  	sh -c "$(curl -fsSL https://raw.githubusercontent.com/rubiin/dotfiles/master/dot_bin/executable_install-all.sh)"
```
To use chezmoi:
chezmoi -- init --apply rubiin




***

## If you like i3, there are two themes available

You can check out instructions on the set up [here](https://github.com/rubiin/dotfiles/blob/master/instructions.md).
## Asakusa Theme
![Asakusa Theme](/i3wm/i3-asakusa-theme/screenshot-asakusa.png)
![Asakusa Theme](/i3wm/i3-asakusa-theme/screenshot-asakusa-stats.png)

## Tokyo Skyline Theme
![Tokyo Skyline Theme](/i3wm/i3-tokyo-skyline-theme/screenshot-tokyo-skyline.png)
![Tokyo Skyline Theme](/i3wm/i3-tokyo-skyline-theme/screenshot-tokyo-skyline-stats.png)

***

# Installation

Install chezmoi and install the dotfiles via it

Note: run `npm i -g neovim` follwed by `nvim +PlugInstall` for neovim install

## Specifications  
* __Debian__
  * Arch Linux - https://www.archlinux.org/
  
  * typical config file path: ~/.config/i3/config
* __bumblebeestatus__
  * config is in the ~/.config/i3/config on the i3bars section
* __alacritty__
  * typical config file path: ~/.config/alacritty/alacritty.yml
* __dunst__
  * lightweight notification daemon - https://dunst-project.org/
  * typical config file path: ~/.config/dunst/dunstrc
* __Compton__
  * standalone composite manager: https://wiki.archlinux.org/index.php/Compton
  * typical config file path: ~/.config/compton.conf
* __redshift__
  * config is in the ~/.config/redshift.conf
* __tmux__
  * config is in the ~/tmux.local.conf
* __Visual Studio Code__
  * version 1.9.0 - https://code.visualstudio.com/
  * user settings: File > Preferences > User Settings
