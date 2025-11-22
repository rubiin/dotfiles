# ~/dotfiles

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/10cfe6e5-5d9a-41cd-8ac4-c1b0f1c17286" />


What are dotfiles, you ask? They’re like the secret sauce that spices up your Unix-like environment, hiding in plain sight.These are the magical objects that make certain computers extremely use-able for me.
Use them wisely, or you may accidentally summon the wrath of the Terminal Gods! ⚡️

**Warning:** Installing these dotfiles may cause unexpected side effects, including but not limited to:

- **Spontaneous Joy**: You may find yourself smiling at your terminal like it just told you a really good joke.
- **Productivity Overload**: Be prepared to finish tasks so quickly that your coworkers will think you’ve discovered time travel.
- **Imposter Syndrome**: A sudden belief that you’re a coding guru, despite the fact that you still don’t know what `grep` does.
- **Keyboard Shortcut Obsession**: You might start using shortcuts for everything—expect your friends to look at you like you’re casting spells.
- **Existential Crises**: You’ll find yourself questioning your life choices as you realize you have more config files than actual files.
- **Terminal Tantrums**: Sudden outbursts of laughter or frustration when the terminal does something unexpected—don’t worry, it happens to the best of us.
- **Unsolicited Tech Support**: Friends and family may suddenly believe you’re a tech wizard and seek your help for their computer problems, whether you’re qualified or not.
- **Random Keyboard Dancing**: You might find yourself doing a little happy dance each time you nail a command on the first try.
- **Binge-Configuring**: Prepare for late nights filled with endless tweaking, as you discover new ways to make your terminal *even cooler*—it’s a slippery slope!
- **Philosophical Debates**: You may start questioning the meaning of life every time you encounter a bug—like, why does this `ls` command keep messing with me?

Use at your own risk, and remember: with great power comes great responsibility (and an abundance of memes). Enjoy the ride! 🚀


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
  - [sheldon](https://sheldon.cli.rs)                                                              : Sheldon is a fast, configurable, command-line tool to manage your shell plugins.
  - [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)       : Fish shell like syntax highlighting for Zsh.
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)                        : Fish-like autosuggestions for zsh
- **Terminal**                     : [wezterm](https://github.com/wez/wezterm)
  - [lazygit](https://github.com/jonas/tig)         : Text-mode interface for git
  - [bat](https://github.com/sharkdp/bat)           : A cat(1) clone with wings
  - [fzf](https://github.com/junegunn/fzf)          : A command-line fuzzy finder
  - [eza](https://github.com/ogham/exa)             : A modern replacement for ‘ls’
  - [btop](https://github.com/aristocratos/btop)    : A monitor of resources
  - [atuin](https://atuin.sh)                       : Sync, search and backup shell history
- **Bar**                          : [Tsumiki](https://github.com/rubiin/Tsumiki) using [nerd fonts](https://github.com/ryanoasis/nerd-fonts)!
  - Catppucin theme(dark)
  - Gruvbox theme (dark)
  - Nord theme (dark)
  - TokyoNight theme (dark)
- **Compositor**                   : [hyprland](https://github.com/hyprwm/Hyprland)
- **Notify Daemon**                : [dunst](https://wiki.archlinux.org/index.php/Dunst)
- **Application Launcher**         : [rofi](https://github.com/davatorium/rofi)
- **Editor**                       : [neovim](https://neovim.io/) -- check my configuration [here](https://github.com/rubiin/init.lua)
- **File Manager**                 : [yazi](https://github.com/sxyazi/yazi) and [dolphin](https://apps.kde.org/dolphin/)
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
| [Zen](https://wiki.archlinux.org/title/firefox)| Terminal | Editors | Utilities (postman/db client) | File Manager | Media players |--- |  [Steam](https://wiki.archlinux.org/title/steam)/[Lutris](https://lutris.net/)  |

- **W`id`**: Workspace with corresponding ID.
- **`---`**: Placeholder, any app can go here.
- **`name`**: Application that opens automatically in its designated workspace.

> [!NOTE]  
> I move random apps that I spawn to special workspace as well

## Demo
https://github.com/prasanthrangan/hyprdots/assets/106020512/7f8fadc8-e293-4482-a851-e9c6464f5265

# Get started
 ```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/rubiin/dotfiles/master/dot_bin/executable_base-install.sh)"
chezmoi init --apply rubiin
```

## FAQS
- Why do you use Arch?
* Because most software are readily available for arch through aur. There is 1 in a 10 chance that something you are not available on aur. Also Arch is minimal by default, allowing users to build their system from the ground up. You     install only what you need, leading to a more efficient setup. Arch teaches you how linux works like how neovim teaches you how an editor works.

- Why use tiling window manager?
* Tiling wm setup makes it easy to navigate with keyboard shortcuts, reducing reliance on the mouse. Tiling WMs are often minimal and customizable, helping users focus on their tasks. They’re also lightweight, suitable for older computers, and great for multitasking, allowing easy access to multiple applications at once. Overall, they offer a more efficient and organized computing experience.

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



