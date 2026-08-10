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

---

## 🔍 Fresh audit — 2026-08-11

> Third pass after the 11–18 fixes. Verified against the live system (`command -v`, grep,
> `chezmoi verify`). Nothing was modified during this pass.

### 🔴 New verified bugs

### 19. `bin/executable_ytd-parrell` — broken twice
- Still invokes `youtube-dl` (not installed; repo migrated to yt-dlp via `ytd`/`ytmp3`) → dies
  with "command not found" at runtime.
- `if [ "$1" == "" ]` under `set -u`: with no args `$1` is unbound, so the usage message
  never prints.

### 20. `zsh/zfunctions/git.zsh` — `gi()` mangles output; `git-redate()` only fixes half the dates
- `gi()`: `curl -sLw n https://…/gitignore/api/$@` — unquoted `$@` breaks multi-pattern calls,
  and `-w n` appends a stray literal `n` to the generated `.gitignore`.
- `git-redate()`: sets `GIT_COMMITTER_DATE` but not `GIT_AUTHOR_DATE` → amend keeps the old
  author date.

### 21. Aliases pointing at uninstalled binaries
- `crap`→`fortune`, `nord`→`nordvpn`, `b`→`bun`, `flush-redis`→`redis-cli`
  — all fail with "command not found" (`command -v` confirmed missing on this machine).


### 23. `zsh/zfunctions/utils.zsh` — `calcram`/`ram`/`rams` depend on `bc` (not installed)

### 24. Privacy leak: `vlc-qt-interface.conf`
- Full personal media library paths (incl. Downloads filenames) committed to the public repo;
  it's runtime state that churns in git. Remove from tracking and gitignore it.

### 25. `dot_local/share/zed/extensions/index.json` — 34 KB runtime cache tracked

### 🟡 Still open (carried over, verified)
- **Bug 1**: catppuccin.gitconfig is both ignored and external (`chezmoi ignored` lists it).
- **pokego** network call runs in both `dot_bashrc` and `dot_zshrc`.
- **`run_onchange_chores.sh`** — no `set -e`, orphaned `hydectl reload &`.
- **Repo 890 MB / `.git` ~800 MB**; `cheatsheets/` PDFs + `fastfetch/logo/` PNGs are the bulk.
- **`validate-compose`** still uses deprecated `docker-compose`.

### 🟢 Optimizations
- `wl-ocr`: `$(which grim)` → `command -v` (avoids silent empty on missing binary).
- `yt-dlp/config`: `--paths $HOME/Videos/youtube-dl` — drop the legacy `youtube-dl` dir name.
- `gh-delete-runs` (git.zsh): `gh run delete $id` → quote `$id`.
