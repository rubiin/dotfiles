# initialize completions with ZSH's compinit
autoload -Uz compinit

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

_comp_options+=(globdots) # tab complete hidden files


