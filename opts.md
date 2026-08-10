# Dotfiles Audit — Findings & Optimizations

> Audit date: 2026-08-10 · Repo: `rubiin/dotfiles` (chezmoi-managed, Arch/EndeavourOS)
> Every finding below was verified against the live system (`chezmoi doctor` / `chezmoi ignored` /
> `chezmoi managed`, file diffs, grep, and reading the rendered `~/.config/chezmoi/chezmoi.toml`).
> Nothing in the repo was modified during the audit.

---

## 🔴 Verified bugs

### 1. `.config/git/catppuccin.gitconfig` is both ignored and fetched
- `.chezmoiignore` contains `.config/git/catppuccin.gitconfig`
- `.chezmoiexternal.toml` downloads it (external of type `file`)
- Confirmed with `chezmoi ignored` → the file is downloaded every refresh but **never applied**.
- **Fix:** remove the ignore line (keep the external) or drop the external entry.





---

## 🟡 Bad practices

- **`[git] autocommit = true, autoPush = true`** (`.chezmoi.toml.tmpl`) — every `chezmoi apply`
  commits and force-pushes to public GitHub with no review. Consider `autoPush = false` +
  periodic manual pushes.
- **Supply-chain risk**: README `curl | sh` bootstrap, `curl https://mise.run | sh`,
  spicetify `curl -fsSL ... | sh`, gpakosz tmux installer — unauthenticated remote scripts with
  sudo-level effect. Pin SHAs / verify before install.
- **`zmodload zsh/zprof`** in `zsh/dot_zshrc` loads the profiler on every interactive shell
  (only needed when actively profiling).
- **`pokego` runs in both `dot_bashrc` and `zsh/dot_zshrc`** → duplicate network call + startup
  latency on every shell.
- **Repo is 890MB**:
  - `.git` alone is **799MB** (3366 commits of accumulated binaries).
  - `private_dot_config/fastfetch/logo/` — **228 PNG logos, 64MB**.
  - `cheatsheets/` — **10 PDFs, 20MB**.
  - pre-commit `check-added-large-files` (default 500KB) is already exceeded by existing files
    → the guard is inconsistent with repo contents.
- **`run_onchange_chores.sh`** — no `set -e`, no `|| true` guards, `hydectl reload &` orphaned;
  regenerates completions on every apply. Works here because all 8
  generator tools are installed; fragile on fresh machines.
- **SSH config** (`private_dot_ssh/private_config`): `Compression yes` (negligible on modern
  links), stale `WarnWeakCrypto no` comment.
- **Docs drift**: `TODO.md` contains the literal placeholder `[FILE_DOES_NOT_EXIST]`; README
  links lazygit→tig and eza→exa, and mentions a Tsumiki bar while hyprpanel configs are in the
  repo.
- **Age passphrase mode** (`[age] passphrase = true`) prompts on every apply of the 4 encrypted
  files — fine for personal use; recipient-based keys are more automation/CI-friendly.
- **`.chezmoi.toml.tmpl` merge escaping** — renders correctly (verified) but the
  `{{`{{ .Destination }}`}}` trick is fragile/confusing; prefer `{{ "{{" }}` for clarity.

---

## 🟢 Optimizations

1. **Drop `zmodload zsh/zprof`**; dedupe `pokego` (once per session, or `precmd` once a day).
3. **Slim the repo**:
   - `git filter-repo` to purge the ~800MB of deleted binaries from history.
   - Move `cheatsheets/` PDFs out of the repo (separate repo / LFS / cloud).
   - Trim `fastfetch/logo/` from 228 PNGs to a handful of favorites.
   - Result: repo drops to a few MB.
4. **Add CI**: GitHub Actions running `pre-commit` + `chezmoi verify --all` on every push.
5. **Consolidate pacman configs** (bug 6) and let chezmoi apply `/etc` files directly.
7. **Drift detection**: systemd timer or pre-push hook running `chezmoi verify --all`.
9. Consider `_evalcache`/lazy-load for `gh-token` (network call per interactive shell).

---

## ✅ Checked and rejected (not bugs)

| Suspect | Verdict |
| --- | --- |
| `{{`{{ .Destination }}`}}` escaping in `.chezmoi.toml.tmpl` `[merge]` args | Renders correctly (verified against `~/.config/chezmoi/chezmoi.toml`) |
| `pacman -Runs` in `clearcache()` (`utils.zsh`) | Valid combo (`-R -u -n -s`); `-u/--unneeded` is a real `-R` option |
| `source "$ZDOTDIR/config/aliases"` in `dot_bashrc` | File **is** chezmoi-managed (`chezmoi managed` finds it; glob missed it — no "zsh" in the name) |
| `chezmoi doctor` errors | Environmental only: cross-device hardlink test, distro-built version (`-tags=noupgrade`) |
| `omp` / `hydectl` completions in `run_onchange_chores.sh` | Both binaries are installed on this machine |
| `pacman -Qtdq` hook writes | Hook now guards `${XDG_CONFIG_HOME:-$HOME/.config}` and writes to `etc/` (bug 5 fixed) |

---

## 🔍 Follow-up audit — new findings (2026-08-10)

> Second pass after the bug 2–9 fixes. Verified against the repo (grep, `chezmoi managed` /
> `ignored`, live `command -v` checks). Nothing was modified during this pass.


### 11. `private_dot_config/git/config` — git-extras aliases point at `$HOME/.bin`, scripts live in `~/.config/bin`
- `cleanup`, `sign-release`, `setup`, `wth` reference `$HOME/.bin/git-extras/...`, but the scripts
  ship in `private_dot_config/bin/git-extras/` → `~/.config/bin/git-extras/` (`bdi` already uses
  the correct path). `setup` additionally names `git-setup.sh` while the file is `git-setup`.
- **Fix:** point all four at `$XDG_CONFIG_HOME/bin/git-extras/…` and fix the `git-setup.sh` name.



### 13. `zsh/config/aliases` — `e*` edit aliases capture `$EDITOR` at definition time (before it is set)
- `evim`/`ebin`/`ezsh`/`ehypr`/`edot`/`ewez`/`egit`/`ealias`/`emux`/`emise` expand `$EDITOR`
  when the aliases file is sourced from `.zshrc`. `EDITOR` is exported in `dot_zlogin` (line 24),
  which runs **after** `.zshrc` → the aliases are defined with an empty editor on stock setups
  (they only work when `EDITOR` happens to be inherited from the environment).
- **Fix:** define them as functions, or single-quote the aliases (`alias evim='$EDITOR ~/.config/nvim'`)
  so expansion is deferred.

### 14. `zsh/config/aliases` — `clear-orphan-packages` / `rate-and-update` repeat fixed landmines
- `clear-orphan-packages='sudo pacman -Qtdq | sudo pacman -Rns -'` errors ("no targets
  specified") with no orphans (zsh sets `PIPE_FAIL` in `executable_options.zsh`) — same class as
  the now-fixed bug 4.
- `rate-and-update` leaks its `mktemp` file if `rate-mirrors` fails (same as the fixed
  `base-install.sh` bug).
- **Fix:** port the `[[ -n $(pacman -Qtdq) ]]` and `trap 'rm -f "$TMPFILE"' EXIT` guards.

### 15. `zsh/config/executable_insulter.zsh` — stray `\` merges two messages; "half the time" gate disabled
- Line 89 ends `"...DUH."\` → the next message is concatenated onto the same string (no space).
- The `# if [[ $((${RANDOM} % 2)) -lt 1 ]]` / `# fi` "annoy the user a little bit less" gate is
  commented out → every failed command now prints an insult.


### 17. `zsh/zfunctions/bat.zsh` — global `-h` / `--help` aliases hijack every occurrence
- `alias -g -- -h='-h 2>&1 | bat ...'` rewrites **every** `-h` token on the command line, e.g.
  `grep -h pattern file` (suppress filename headers) becomes `grep -h pattern file 2>&1 | bat`
  and the flag silently disappears. High footgun for a global alias.
- **Fix:** drop the global aliases or scope them to specific commands.

### 18. `dot_bashrc` sources `$ZDOTDIR/config/aliases` — `ZDOTDIR` is a zsh-ism
- In plain bash (login from TTY/DM), `ZDOTDIR` is unset → `source /config/aliases` fails on
  every start; it only works when bash is spawned from a zsh that exported `ZDOTDIR`. (The
  earlier "checked and rejected" row verified the *file* is managed — this is about the var.)
- **Fix:** `${ZDOTDIR:-$HOME/.config}/config/aliases` (or source `~/.config/zsh/config/aliases`).


## 🟢 Follow-up optimizations

1. **`git/config`** — `[core] hooksPath = ~/.config/git/hooks` points at a dir with no shipped
   hooks; either ship some or drop the setting.
2. **`zsh/config/aliases`** — stale tools: `yt="youtube-dl"` (not installed; `ytd="yt-dlp"`
   exists) and `dc="docker-compose"` (deprecated → `docker compose`); `localip`/`ips` use the
   deprecated `ifconfig` (net-tools) — switch to `ip -4 addr`/`ip -6 addr`.
3. **`dot_zlogin`** — `GNUPGHOME` is exported twice (`$XDG_DATA_HOME/gnupg` then
   `$XDG_DATA_HOME/gpg`); keep the one matching `base-install.sh` (`~/.local/share/gpg`).
4. **`chezmoi doctor`** — warns about a dirty source working tree; expected mid-work, but with
   `autoPush = true` (see bad practices) every `chezmoi apply` pushes these findings
   automatically — review before committing.

---

## Quick file index

- `private_dot_config/zsh/dot_zshrc` — zprof, p10k instant prompt via sheldon, `ZSH_SOURCE_DIRS`, pokego
- `private_dot_config/zsh/config/executable_completions.zsh` — single compinit + fpath (zcompletions/zfunctions autoloaded)
- `private_dot_config/zsh/zfunctions/utils.zsh` — `ffmpeg-convert`/`convert-dir-vids` (fixed), `clearcache`, misc helpers
- `private_dot_config/zsh/zfunctions/git.zsh` — `gi()` unquoted `$@`, `git-redate` missing `GIT_AUTHOR_DATE`
- `private_dot_config/zsh/config/executable_insulter.zsh` — stray `\` merging two strings
- `dot_bashrc` / `dot_bash_profile` / `dot_bashenv` — double mise init, `$ZDOTDIR` in bash, dead `.bashenv`/`.zprofile` sources
- `private_dot_config/bin/executable_base-install.sh` — fresh-install bootstrap script (hardened)
- `private_dot_config/etc/hooks/pacman-list.hook` — pkglist hook, env-guarded
- `private_dot_config/etc/` — pacman/system configs, copied into place as needed
- `run_onchange_chores.sh` — no guards, orphaned background job, regenerates completions on every apply
- `.chezmoiignore` / `.chezmoiexternal.toml` — catppuccin.gitconfig conflict
- `.chezmoi.toml.tmpl` — `autoPush = true`
- `private_dot_config/git/config` — `it fetch` typos, `$HOME/.bin` git-extras paths, empty `hooksPath`
- `private_dot_config/zsh/config/aliases` — `$EDITOR`-capture `e*` aliases, orphan/mirror landmines, stale `yt`/`dc`/`ifconfig`
- `dot_bashenv` — dead file (never sourced)
- `private_dot_config/zsh/zfunctions/bat.zsh` — global `-h`/`--help` aliases footgun
