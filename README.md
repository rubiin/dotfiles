# ~/dotfiles

Magical objects that make certain computers extremely use-able for me.

<img src="https://i.imgur.com/dWiAjUx.gif" height=250/>


<br>

<br>

<table align="right">
  <tr>
    <td align="center">
      <sup>
            <samp>
                  If you like this setup, please drop  a star.<br>
                  I really appreciate it.
                  Thanks!
            </samp>
      </sup>
    </td>
  </tr>



</table>

Here are some details about my setup:

- **Window Manager**               : [hypr](https://github.com/hyprwm/Hypr)  
- **Shell**                        : [zsh](https://github.com/zsh-users/zsh)
  - [spaceship-prompt](https://github.com/spaceship-prompt/spaceship-prompt)                       : Minimalistic, powerful and extremely customizable Zsh prompt
  - [ohmyzsh](https://github.com/zplug/zplug)                                                        : A next-generation plugin manager for zsh
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)                : Fish shell like syntax highlighting for Zsh.
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)                        : Fish-like autosuggestions for zsh
- **Terminal**                     : [kitty](https://github.com/kovidgoyal/kitty)
  - [lazygit](https://github.com/jonas/tig)         : Text-mode interface for git
  - [bat](https://github.com/sharkdp/bat)           : A cat(1) clone with wings
  - [fzf](https://github.com/junegunn/fzf)          : A command-line fuzzy finder
  - [eza](https://github.com/ogham/exa)             : A modern replacement for ‘ls’
  - [btop](https://github.com/aristocratos/btop)    : A monitor of resources
- **Bar**                          : [waybar](https://github.com/polybar/polybar) using [nerd fonts](https://github.com/ryanoasis/nerd-fonts)!
  - Gruvbox theme (dark)
  - Catppucin theme(dark)
  - Nord theme (dark)
  - TokyoNight theme (dark)
- **Compositor**                   : [hyprland](https://github.com/hyprwm/Hyprland)   
- **Notify Daemon**                : [dunst](https://wiki.archlinux.org/index.php/Dunst)
- **Application Launcher**         : [rofi](https://github.com/davatorium/rofi)
- **Music Player**                 : [mpd](https://www.musicpd.org/) & [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp)   
- **Editor**                       : [neovim](https://neovim.io/) -- check my configuration [here](https://github.com/rubiin/init.lua)
- **File Manager**                 : [ranger](https://github.com/ranger/ranger) | [thunar](https://docs.xfce.org/xfce/thunar/start)
- **CLI System Information**       : [fastfetch](https://github.com/dylanaraps/neofetch)

<br>


<details close>
    <summary><samp><b>more info</b></samp></summary>


<br>

* **Fonts?**
    * as for fonts, the setup uses 4 fonts in total
        - *MonoLisa* - main ui font
        - *Nerd Icons* - for icons
        - *𝘔𝘢𝘱𝘭𝘦𝘔𝘰𝘯𝘰 - alternate font
        - *𝘑𝘦𝘵𝘉𝘳𝘢𝘪𝘯𝘴𝘔𝘰𝘯𝘰 𝘕𝘦𝘳𝘥 𝘍𝘰𝘯𝘵* - waybar,rofi
<br>

</details>


## Demo
https://github.com/prasanthrangan/hyprdots/assets/106020512/7f8fadc8-e293-4482-a851-e9c6464f5265

# Get started
 ```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/rubiin/dotfiles/master/dot_bin/executable_install-all.sh)"
chezmoi init --apply rubiin
```

Might want this https://www.cyberciti.biz/open-source/command-line-hacks/adding-spice-to-your-sudo-session-with-a-lecture-file-on-linux-or-unix/

# If you use i3wm, check the branch [i3wm](https://github.com/rubiin/dotfiles/tree/i3wm) for my i3 rice
# If you use kde, check the  [kde](https://github.com/rubiin/dotfiles/tree/kde) branch
