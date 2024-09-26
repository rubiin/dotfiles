# DOCS https://zsh.sourceforge.io/Doc/Release/Options.html
# DOCS https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell
#───────────────────────────────────────────────────────────────────────────────

# GENERAL
setopt INTERACTIVE_COMMENTS # comments in interactive mode, useful for copypasting
setopt GLOB_DOTS            # glob includes dotfiles
setopt PIPE_FAIL            # tracability: exit if pipeline failed
setopt NO_BANG_HIST         # don't expand `!`
setopt NO_BEEP              # No bell: Shut up Zsh
setopt NO_HUP               # don't kill background jobs when the shell exits
setopt AUTO_CD              # pure directory = cd into it
setopt CD_SILENT
setopt CHASE_LINKS # follow symlinks when they are cd target

# HISTORY 
setopt EXTENDED_HISTORY          # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY             # share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate.
setopt HIST_NO_STORE             # ignore history command itself for the history
setopt HIST_IGNORE_SPACE         # cmds with leading space are not added to the history
setopt INC_APPEND_HISTORY	 # write immediately to history file
setopt EXTENDED_GLOB
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS


