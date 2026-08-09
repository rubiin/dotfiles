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

### 2. Generated zsh completions are dead weight and slow startup
- `run_onchange_chores.sh` generates 9 completions (`_npm`, `_docker`, `_gh`, `_delta`, `_mise`,
  `_just`, `_omp`, `_hydectl`, `_git-extras`) into `$ZDOTDIR/zcompletions`.
- **`fpath` is never set anywhere** in `private_dot_config/zsh/` or `private_dot_config/sheldon/`
  (verified with grep). `ZSH_SOURCE_DIRS` in `zsh/dot_zshrc` only *sources* those files directly.
- Completion scripts are meant to be autoloaded by `compinit` via `fpath`; sourcing them defines
  `_npm` etc. but they are never registered with `compinit` → `npm <TAB>` etc. doesn't complete,
  and sourcing adds startup cost.
- **Fix:** add before compinit:
  ```zsh
  fpath+=("$ZDOTDIR/zcompletions" "$ZDOTDIR/zfunctions")
  autoload -Uz compinit
  ```
  and remove `zcompletions` from `ZSH_SOURCE_DIRS`.

### 3. Double `compinit` + broken daily-recompile shortcut
- `compinit` runs in **both** `zsh/config/executable_completions.zsh` and
  `zsh/config/executable_compinit.zsh` → full compinit twice per shell.
- Both check `~/.zcompdump` but the real dump lives at `$ZDOTDIR/.zcompdump`
  (`~/.config/zsh/.zcompdump` exists; `~/.zcompdump` does not) → the `compinit -C` fast path
  never triggers → full recompile every startup.
- **Fix:** keep one compinit block and glob `$ZDOTDIR/.zcompdump` instead of `~/.zcompdump`.

### 4. `bin/executable_base-install.sh` — `set -e` landmines (abort a fresh install)
- `mkdir "$XDG_CONFIG_HOME/wakatime"` → if `XDG_CONFIG_HOME` is unset this becomes `/wakatime`
  → permission denied → **whole script dies**.
- `sudo swapoff -a` → fails when no swap exists → dies.
- `sudo pacman -Qtdq | sudo pacman -Rns -` → "no targets specified" when no orphans → dies.
  Guard with `[[ -n $(pacman -Qtdq) ]] && ...`.
- `yay -s docker` → invalid flag, should be `yay -S docker`.
- `sudo tee -a /etc/sudoers` (lecture block) without `visudo -c` validation — a syntax error
  locks the user out of sudo.
- `ask_yes_no_default` + `set -e`: declining an option runs the guard correctly, but the
  non-guarded commands above are unconditional hazards.
- Minor: `mktemp` file from `rate-mirrors` is not cleaned up on failure; `curl | sh` for
  spicetify/mise/tmux is unauthenticated (see bad practices).

### 5. `~/.config/pacman/hooks/pacman-list.hook` — `$XDG_CONFIG_HOME` in root context
- `Exec = /bin/sh -c 'pacman -Qqen > "$XDG_CONFIG_HOME/pacman/pkglist.txt"; ...'`
- Runs as root inside pacman. If the invoking sudo doesn't preserve the env (fresh machine,
  default sudoers), `XDG_CONFIG_HOME` is empty → writes to `/pacman/pkglist.txt` at the
  filesystem root.
- Works on this machine only because the env passes through.
- **Fix:** `${XDG_CONFIG_HOME:-$HOME/.config}` guard.

### 6. `~/.config/etc` vs `~/.config/pacman` — full duplication
- `private_dot_config/etc/` and `private_dot_config/pacman/` contain **identical** tracked files
  (pacman.conf, pacman-contrib, pkglist.txt, pkglist-aur.txt, hooks/) — verified with `diff -rq`.
- But two sources of truth: the pacman hook live-updates `~/.config/pacman/`; `base-install.sh`
  copies from `~/.config/etc/`; `etc/README.md` says "copy into place as needed".
- Guaranteed drift + git churn on every package transaction.
- **Fix:** consolidate to one location. Recommended: keep `~/.config/pacman/` as the live hook
  target, and use chezmoi's `etc/` source dir (or a `run_onchange` script) to push
  `/etc/pacman.conf` + hooks into place instead of manual copies.

### 7. `zsh/zfunctions/utils.zsh: convert-dir-vids`
- Calls `ffmpeg_convert` but the function is defined as `ffmpeg-convert` → command not found.
- `rm $(ls -I "cc*")` — unquoted, breaks on filenames with spaces, and can delete more than
  intended; `ls` output on dirs breaks `rm`.
- `echo "$Green ... \n"` prints a literal `\n` (no `-e`).

### 8. `dot_bashrc` — hardcoded machine path
```bash
alias claude-mem='bun "/home/devina/.claude/plugins/cache/thedotmack/claude-mem/12.3.2/scripts/worker-service.cjs"'
```
- Pins a user home + a **versioned** plugin path (12.3.2) → breaks on plugin updates and on any
  other machine. Use `$HOME` and a glob/unversioned path, or drop the alias.

### 9. p10k instant-prompt ordering broken + 3 competing prompt init paths
- `zsh/dot_zshrc` runs `eval "$(sheldon source)"` (loads p10k) **before** sourcing the
  p10k-instant-prompt cache — instant prompt must be sourced before the theme initializes.
- Three competing paths: sheldon-managed p10k (`plugins.powerlevel10k`), hardcoded
  `/usr/share/zsh-theme-powerlevel10k/...` fallback, and a starship fallback branch.
- Works on this machine only because the system p10k package is not installed
  (verified: no `/usr/share/zsh-theme-powerlevel10k`, sheldon clone exists).
- **Fix:** pick one path (recommend sheldon) and remove the dead branches.

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
- **bashrc double-inits mise**: `eval "$(~/.local/bin/mise activate bash)"` in `dot_bashrc` +
  `eval "$(mise activate bash --shims)"` in `dot_bash_profile`.
- **Repo is 890MB**:
  - `.git` alone is **799MB** (3366 commits of accumulated binaries).
  - `private_dot_config/fastfetch/logo/` — **228 PNG logos, 64MB**.
  - `cheatsheets/` — **10 PDFs, 20MB**.
  - pre-commit `check-added-large-files` (default 500KB) is already exceeded by existing files
    → the guard is inconsistent with repo contents.
- **`run_onchange_chores.sh`** — no `set -e`, no `|| true` guards, `hydectl reload &` orphaned;
  regenerates completions on every apply (see bug 2 — wasted work). Works here because all 8
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

1. **Fix fpath + single compinit** (bugs 2 & 3) → working completions *and* faster startup.
2. **Drop `zmodload zsh/zprof`**; dedupe `pokego` (once per session, or `precmd` once a day).
3. **Slim the repo**:
   - `git filter-repo` to purge the ~800MB of deleted binaries from history.
   - Move `cheatsheets/` PDFs out of the repo (separate repo / LFS / cloud).
   - Trim `fastfetch/logo/` from 228 PNGs to a handful of favorites.
   - Result: repo drops to a few MB.
4. **Add CI**: GitHub Actions running `pre-commit` + `chezmoi verify --all` on every push.
5. **Consolidate pacman configs** (bug 6) and let chezmoi apply `/etc` files directly.
6. **Harden `base-install.sh`** with the guards from bug 4 so a fresh install can't abort
   mid-way; add `visudo -c` before touching `/etc/sudoers`.
7. **Drift detection**: systemd timer or pre-push hook running `chezmoi verify --all`.
8. **Hook env robustness**: `${XDG_CONFIG_HOME:-$HOME/.config}` in `pacman-list.hook`.
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
| `pacman -Qtdq` hook writes | Works here because `XDG_CONFIG_HOME` is set and passes through sudo (still fragile — see bug 5) |

---

## Quick file index

- `private_dot_config/zsh/dot_zshrc` — zprof, prompt paths, `ZSH_SOURCE_DIRS`, pokego
- `private_dot_config/zsh/config/executable_completions.zsh` + `executable_compinit.zsh` — double compinit
- `private_dot_config/zsh/zfunctions/utils.zsh` — `convert-dir-vids`/`ffmpeg_convert` bug, `clearcache`
- `private_dot_config/zsh/zfunctions/git.zsh` — `gi()` unquoted `$@`, `git-redate` missing `GIT_AUTHOR_DATE`
- `private_dot_config/zsh/config/executable_insulter.zsh` — stray `\` merging two strings
- `dot_bashrc` / `dot_bash_profile` / `dot_bashenv` — hardcoded path, double mise, dead `.zprofile` source
- `private_dot_config/bin/executable_base-install.sh` — `set -e` landmines, `yay -s`, sudoers
- `private_dot_config/pacman/hooks/pacman-list.hook` — `$XDG_CONFIG_HOME` fragility
- `private_dot_config/etc/` vs `private_dot_config/pacman/` — duplication
- `run_onchange_chores.sh` — no guards, orphaned background job, dead completion generation
- `.chezmoiignore` / `.chezmoiexternal.toml` — catppuccin.gitconfig conflict
- `.chezmoi.toml.tmpl` — `autoPush = true`
