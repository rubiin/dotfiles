# organize handy reusable functions to keep your .zshrc clean and modular.
#─────────────────────────────────────────────────────────────────────────
prepend_path() {
  [[ ! -d "$1" ]] && return

  path=(
      $1
      $path
  )
}

# unmanages the file from chezmoi also deletes it
czx() {
	echo "$1"
	cz forget "$1"
	rm -rf "$1"
}

# Show the path of a command, colorized and showing all matches
function which {
	builtin which -a "$@" | bat --language=sh --wrap=character
}

# Show the path of a command, colorized and showing all matches
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do time $shell -i -c exit; done
}

show_memory(){
  ps aux --sort=-%mem | grep $1 | awk 'NR==1 || $4 > 0 {printf "%.1f MB\t%s\n", $6/1024, $11}' | head

}

watch_mem_usage() {
    local process_name="$1"
    local interval="${2:-4}" # Default to 4 seconds if not provided
    watch -n "$interval" "ps aux --sort=-%mem | grep -w \"$process_name\" | grep -v grep | awk 'NR==1 || \$4 > 0 {printf \"%.1f MB\t%s\n\", \$6/1024, \$11}'"
}

clearcache() {
	yay -Sc --noconfirm
	sudo pacman -Runs --noconfirm $(pacman -Qttdq)
	paccache -rvk0
	paccache -rvk0 ~/.cache/yay

}

sssh() {
	# try to connect every 0.5 secs (modulo timeouts)
	while true; do
		command ssh "$@"
		[ $? -ne 255 ] && break || sleep 0.5
	done
}

code_update_extensions() {
	for ext in $(code --list-extensions); do
		code --install-extension "$ext" --force
	done
}

ffmpeg-convert() {
	for i in *.mp4; do
		ffmpeg -n -i "$i" -vcodec libx264 -v warning -hide_banner -stats -crf 28 -preset faster -tune film "cc${i}"
	done
}

convert-dir-vids() {
	Green=$'\e[1;32m'
	Blue=$'\e[1;34m'
	echo "$Blue Started converting videos in dir"
	for d in ./*/; do (echo "$Green Current directory: $d \n" && cd "$d" && ffmpeg_convert && rm $(ls -I "cc*")); done
	echo "finished converting all videos in directory"
}

zsh-fix-history() {
	cd ~
	mv .zsh_history .zsh_history_old
	strings .zsh_history_old >.zsh_history
	fc -R .zsh_history
}


take() {
		mkdir -p "$1" && cd "$1";
	 }


# Calculate RAM usage of a process by its name.
function calcram() {
	local sum
	sum=0
	for i in $(ps aux | grep -i "$1" | grep -v "grep" | awk '{print $6}'); do
		sum=$(($i + $sum))
	done
	sum=$(echo "scale=2; $sum / 1024.0" | bc)
	echo $sum
}

# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM
function ram() {
	local sum
	local app="$1"
	if [ -z "$app" ]; then
		echo "First argument - pattern to grep from processes"
		return 0
	fi

	sum=$(calcram $app)
	if [[ $sum != "0" ]]; then
		echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM"
	else
		echo "No active processes matching pattern '${fg[blue]}${app}${reset_color}'"
	fi
}

# Same, but tracks RAM usage in realtime. Will run until you stop it.
# $ rams safari
function rams() {
	local sum
	local app="$1"
	if [ -z "$app" ]; then
		echo "First argument - pattern to grep from processes"
		return 0
	fi

	while true; do
		sum=$(calcram $app)
		if [[ $sum != "0" ]]; then
			echo -en "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM\r"
		else
			echo -en "No active processes matching pattern '${fg[blue]}${app}${reset_color}'\r"
		fi
		sleep 1
	done
}

# $ size dir1 file2.js
function size() {
	# du -scBM | sort -n
	du -shck "$@" | sort -rn | awk '{
      function human(x) {
          s="kMGTEPYZ";
          while (x>=1000 && length(s)>1)
              {x/=1024; s=substr(s,2)}
          return int(x+0.5) substr(s,1,1)
      }
      {gsub(/^[0-9]+/, human($1)); print}'
}

# Reinstall nvim config from git repo
function reinstall-nvim() {
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim
	git clone git@github.com:rubiin/init.lua .config/nvim
	if [[ ! -d ~/personal/vim ]]; then
		mkdir ~/personal/vim
		git clone git@github.com:rubiin/fortune.nvim.git ~/personal/vim/fortune.nvim
		git clone git@github.com:rubiin/highlighturl.nvim.git ~/personal/vim/highlighturl.nvim
		git clone git@github.com:rubiin/vimwordlist.nvim.git ~/personal/vim/vimwordlist.nvim
	fi
	nvim
}

# Query http://cheat.sh for help with a command
cheat() {
	curl cheat.sh/"$1"
}

# Open a file in the default editor, or in nvim if specified
sesh_sessions() {
	sesh connect \"$(
		sesh list -i | fzf-tmux -p 55%,60% \
			--no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
			--header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
			--bind 'tab:down,btab:up' \
			--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
			--bind 'ctrl-t:change-prompt(  )+reload(sesh list -t)' \
			--bind 'ctrl-g:change-prompt(  )+reload(sesh list -c)' \
			--bind 'ctrl-x:change-prompt(󱁿  )+reload(sesh list -z)' \
			--bind 'ctrl-f:change-prompt(  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
			--bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
	)
}
