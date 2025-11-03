# keybinds
function sesh-sessions() {
	{
		exec </dev/tty
		exec <&1
		local session
		session=$(sesh list -i | fzf --ansi --height 40% --reverse --border-label '  TMUX Session Manager (sesh) ' --border --prompt '⚡  ')
		zle reset-prompt >/dev/null 2>&1 || true
		[[ -z "$session" ]] && return
		sesh connect $session
	}
}

zle -N sesh-sessions
bindkey -M vicmd '^O' sesh-sessions
bindkey -M viins '^O' sesh-sessions
