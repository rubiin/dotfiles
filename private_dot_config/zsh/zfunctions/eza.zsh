# ls
if command -v "eza" &>/dev/null; then
	alias l='eza -lh  --icons=auto'                                        # long list
	alias ls='eza -1   --icons=auto'                                       # short list
	alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
	alias ld='eza -lhD --icons=auto'                                       # long list dirs
	alias lt='eza --icons=auto --tree'
fi
