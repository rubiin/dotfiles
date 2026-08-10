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
