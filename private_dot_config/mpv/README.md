## mpv Configuration & Scripts

This repository contains a curated set of configuration files and user scripts for [mpv](https://mpv.io/), enhancing its usability, automation, and visual experience.


---

### Table of Contents
- [Overview](#overview)
- [Configuration Files](#configuration-files)
- [Scripts](#scripts)
- [Script Options](#script-options)
- [Usage](#usage)
- [Credits & References](#credits--references)

---

## Overview
This setup customizes mpv with:
- Modern on-screen controls (OSC)
- Enhanced thumbnail previews
- Pause/play indicators
- SponsorBlock integration
- Smart copy-paste for media URLs
- Subtitle download automation
- VLC-style cropping
- Miscellaneous usability improvements

---

## Configuration Files

- **mpv.conf**: Main mpv configuration (UI, OSD, playback, playlist, window, etc.)
- **input.conf**: Custom keybindings for volume, seeking, subtitles, and script triggers.

---

## Scripts

All scripts are in the `scripts/` directory. Place them in your mpv `scripts/` folder to enable.

- **modernz.lua**: Modern, customizable OSC (on-screen controller) with themes and advanced features. [ModernZ](https://github.com/Samillion/ModernZ)
- **thumbfast.lua**: High-performance on-the-fly thumbnail generator for seeking previews. [thumbfast](https://github.com/po5/thumbfast)
- **pause_indicator.lua**: Shows a pause/play indicator overlay when playback is paused.
- **confirm_resume.lua**: Shows a confirmation prompt for resuming playback.
- **sponsorblock_minimal.lua**: Skips sponsored segments in YouTube videos using SponsorBlock API. [SponsorBlock](https://github.com/ajayyy/SponsorBlock)
- **SmartCopyPaste.lua**: Copy/paste media URLs and playback positions with smart keybinds. [SmartCopyPaste](https://github.com/Eisa01/mpv-scripts)
- **autoloop.lua**: Automatically loops short files and manages save position for longer ones. [autoloop](https://github.com/zydezu/mpvconfig)
- **misc.lua**: Simple scripts that are way small for their own file
- **vlccompat.lua**: Things to make mpv somewhat vlc like
- **subit.lua**: Download subtitles using [subliminal](https://github.com/Diaoul/subliminal) (Python required).
- **vlccrop.lua**: Cycle through common aspect ratios with 'c', like VLC. [vlccrop](https://github.com/kism/mpvscripts)

---

## Script Options

Script options are in the `script-opts/` directory. Edit these files to customize script behavior:

- **modernz.conf**: Options for ModernZ OSC (language, theme, behavior, etc.)
- **thumbfast.conf**: Options for thumbnail generation (timeout, tone mapping, etc.)
- **confirm_resume.conf**: Options for confirmation prompt (text, wait interval, etc.)
- **evafast.conf**: Options for seeking and playback speed adjustments.

---

## Usage

1. **Install mpv**: [mpv.io](https://mpv.io/installation/)
2. **Copy files**: Place `mpv.conf`, `input.conf`, and the `scripts/` and `script-opts/` folders into your mpv config directory (usually `~/.config/mpv/`).
3. **Install dependencies** (optional):
	- For `subit.lua`: Install Python and `subliminal` (`pip install subliminal`).
	- For SponsorBlock: Internet connection required.
4. **Customize**: Edit the `.conf` files in `script-opts/` to adjust script settings.
5. **Keybindings**: See `input.conf` for custom keys (e.g., volume, seek, crop, subtitle, script triggers).

---

## Credits & References

- [mpv](https://mpv.io/)
- [ModernZ OSC](https://github.com/Samillion/ModernZ) by Samillion
- [thumbfast](https://github.com/po5/thumbfast) by po5
- [pause-indicator-lite](https://github.com/Samillion/ModernZ/tree/main/extras/pause-indicator-lite)
- [SponsorBlock](https://github.com/ajayyy/SponsorBlock)
- [SmartCopyPaste](https://github.com/Eisa01/mpv-scripts) by Eisa AlAwadhi
- [autoloop](https://github.com/zydezu/mpvconfig)
- [vlccrop](https://github.com/kism/mpvscripts)
- [subliminal](https://github.com/Diaoul/subliminal)

---

For more details, see the comments in each script and config file.
