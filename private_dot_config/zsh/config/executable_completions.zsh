# tells zsh to ignore case when completing commands or filenames.
# setopt GLOB_COMPLETE      # Show autocompletion menu with globs

# Should be called before compinit
zmodload zsh/complist

# initialise completions with ZSH's compinit
autoload -Uz compinit

for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C

_comp_options+=(globdots) # tab complete hidden files

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort modification


# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'


