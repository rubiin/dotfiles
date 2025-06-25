# DOCS https://zsh.sourceforge.io/Doc/Release/Options.html
# DOCS https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell
#───────────────────────────────────────────────────────────────────────────────

# GENERAL
setopt INTERACTIVE_COMMENTS        # comments in interactive mode, useful for copypasting
setopt GLOB_DOTS                   # glob includes dotfiles
setopt PIPE_FAIL                   # tracability: exit if pipeline failed
setopt NO_BANG_HIST                # don't expand `!`
setopt NO_BEEP                     # No bell: Shut up Zsh
setopt NO_HUP                      # don't kill background jobs when the shell exits
setopt PROMPT_SUBST                # allow prompt to be evaluated as a command
setopt EXTENDED_GLOB               # enable advanced pattern matching in file name


# HISTORY
setopt EXTENDED_HISTORY            # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS          # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY               # share history between all sessions.
setopt HIST_NO_STORE               # ignore history command itself for the history
setopt HIST_IGNORE_SPACE           # cmds with leading space are not added to the history
setopt INC_APPEND_HISTORY          # write immediately to history file
setopt HIST_IGNORE_ALL_DUPS        # delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS            # skip saving a command if it’s the same as the previous one.
setopt HIST_VERIFY                 # edit a recalled history command before executing it
setopt HIST_FIND_NO_DUPS           # ignore duplicates during reverse (Ctrl-R) history search.
setopt HIST_SAVE_NO_DUPS           # ignore duplicates when saving history.

setopt HIST_EXPIRE_DUPS_FIRST      # prefer deleting old duplicates before trimming other history

# ohmyzsh compat
setopt MULTIOS                    # enable redirect to multiple streams: echo >file1 >file2
setopt LONG_LIST_JOBS             # show long list format job notifications
unsetopt MENU_COMPLETE            # do not autoselect the first completion entry
setopt AUTO_MENU                  # show completion menu on successive tab press
unsetopt FLOWCONTROL              # disable flow control (^S/^Q) in the terminal
setopt COMPLETE_IN_WORD           # allows tab-completion in the middle of a word, not just at the end.
setopt ALWAYS_TO_END              # always append to the end of the line when completing a command.

# vi mode
export KEYTIMEOUT=1
export VI_MODE_SET_CURSOR=true

setopt AUTO_PUSHD                 # push the current directory visited on the stack.
setopt AUTO_CD                    # pure directory = cd into it
setopt CHASE_LINKS                # follow symlinks when they are cd target
setopt CD_SILENT                  # do not print the directory after `cd` command
setopt LOGIN                      # make the shell act as a login shell
setopt PUSHD_MINUS                # use `-` with `pushd` to go back in directory stack (like `cd -`)
setopt PUSHD_IGNORE_DUPS          # do not store duplicates in the stack.
setopt PUSHD_SILENT               # do not print the directory stack after pushd or popd.
