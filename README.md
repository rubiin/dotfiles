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
  - [powerlevel10k-prompt](https://github.com/romkatv/powerlevel10k)                               : Minimalistic, powerful and extremely customizable Zsh prompt
  - [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)                                                : A next-generation framework for zsh
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)                : Fish shell like syntax highlighting for Zsh.
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)                        : Fish-like autosuggestions for zsh
- **Terminal**                     : [wezterm](https://github.com/wez/wezterm)
  - [lazygit](https://github.com/jonas/tig)         : Text-mode interface for git
  - [bat](https://github.com/sharkdp/bat)           : A cat(1) clone with wings
  - [fzf](https://github.com/junegunn/fzf)          : A command-line fuzzy finder
  - [eza](https://github.com/ogham/exa)             : A modern replacement for ‘ls’
  - [btop](https://github.com/aristocratos/btop)    : A monitor of resources
- **Bar**                          : [waybar](https://github.com/Alexays/Waybar) using [nerd fonts](https://github.com/ryanoasis/nerd-fonts)!
  - Catppucin theme(dark)
  - Gruvbox theme (dark)
  - Nord theme (dark)
  - TokyoNight theme (dark)
- **Compositor**                   : [hyprland](https://github.com/hyprwm/Hyprland)
- **Notify Daemon**                : [dunst](https://wiki.archlinux.org/index.php/Dunst)
- **Application Launcher**         : [rofi](https://github.com/davatorium/rofi)
- **Editor**                       : [neovim](https://neovim.io/) -- check my configuration [here](https://github.com/rubiin/init.lua)
- **File Manager**                 : [yazi](https://github.com/sxyazi/yazi)
- **CLI System Information**       : [fastfetch](https://github.com/fastfetch-cli/fastfetch)

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


## Current Workflow

| W1  | W2                                                  | W3  | W4                                                  | W5                                           | W6                                                  | W7                                                                            | W8 |
| --- | --------------------------------------------------- | --- | --------------------------------------------------- | -------------------------------------------- | --------------------------------------------------- | ----------------------------------------------------------------------------- | --- |
| [Firefox](https://wiki.archlinux.org/title/firefox)| Terminal | Editors | Utilities (postman/db client) | File Manager | Media players |--- |  [Steam](https://wiki.archlinux.org/title/steam)/[Lutris](https://lutris.net/)  |

- **W`id`**: Workspace with corresponding ID.
- **`---`**: Placeholder, any app can go here.
- **`name`**: Application that opens automatically in its designated workspace.

|> Also I move random apps that I spawn to special workspace

## Demo
https://github.com/prasanthrangan/hyprdots/assets/106020512/7f8fadc8-e293-4482-a851-e9c6464f5265

# Get started
 ```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/rubiin/dotfiles/master/dot_bin/executable_base-install.sh)"
chezmoi init --apply rubiin
```

## Disclaimer 📝

These dotfiles are provided as-is, without any warranty or guarantee of any kind. Use them at your own risk.

### Important Points:
1. **Backup Your Existing Configuration**: Before applying these dotfiles, ensure you have backed up your existing configuration files. This is crucial to prevent any loss of your custom settings. You can use tools like `cp` or `rsync` to create backups of your current configurations. Think of it like making a save point in a video game before facing the final boss. You don't want to lose all your progress!

2. **Review Before Applying**: Carefully review the contents of these dotfiles to understand the changes they will make to your system. This includes checking scripts, configuration settings, and any software they might interact with. Make sure they meet your specific needs and don't interfere with your existing setup.

3. **Compatibility**: These dotfiles are tailored to my personal development environment, which might include specific versions of operating systems, shells, and software packages. They might not be compatible with all systems or setups. Adjustments may be necessary to suit your particular environment. Ensure that dependencies are installed and compatible with your system.

4. **Security**: Be mindful of potential security implications. Do not blindly trust any configuration files you find online, including these. Always inspect the content for any potentially harmful commands. Pay special attention to scripts that modify system settings, download files, or have root permissions.

5. **Personal Preferences**: These configurations reflect my personal workflow and preferences, including shortcuts, themes, and extensions. Feel free to modify them to better suit your own workflow. You may want to change themes, key bindings, or other settings to match your own preferences.

6. **System Performance**: Some configurations might affect system performance, especially if they include resource-intensive scripts or settings. Monitor your system after applying these dotfiles to ensure they do not negatively impact performance.

7. **Updates and Maintenance**: These dotfiles may evolve over time. Keep an eye on updates to ensure compatibility with new software versions and to benefit from improvements. Regularly check for updates and changes that might be beneficial or necessary for your setup.. It's like keeping up with the latest memes – you don't want to be left out.

8. **Community Contributions**: If you find these dotfiles useful and make improvements, consider contributing back to the repository. Sharing your modifications can help others in the community benefit from your enhancements.

---

By using these dotfiles, you acknowledge that you understand these points and accept the responsibility for any changes they make to your system. If you encounter issues or have questions, feel free to open an issue or reach out for support.

# If you use i3wm, check the branch [i3wm](https://github.com/rubiin/dotfiles/tree/i3wm) for my i3 rice
# If you use kde, check the  [kde](https://github.com/rubiin/dotfiles/tree/kde) branch



