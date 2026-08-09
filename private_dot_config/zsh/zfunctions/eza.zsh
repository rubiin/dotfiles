

# Helpful ls aliases
if command -v "eza" &>/dev/null; then
    alias eza='eza --icons=auto --color=auto'                   # default: icons + colors
    alias l='eza -lh'                                           # long list (human-readable)
    alias ls='eza -1'                                           # short list (one per line)
    alias ll='eza -lha --sort=name --group-directories-first'   # long list all + sorted
    alias ld='eza -lhD'                                         # directories only
    alias lt='eza --tree'                                       # tree view

fi
