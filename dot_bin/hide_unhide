#!/usr/bin/env sh
#
# show desktop on hyperland


stack_file="/tmp/hide_window_pid_stack.txt"


hide_window(){
	pid=$(hyprctl activewindow -j | jq '.pid')
	hyprctl dispatch movetoworkspacesilent 88,pid:$pid
	echo $pid >> $stack_file
}

show_window(){
	pid=$(tail -1 $stack_file && sed -i '$d' $stack_file)
	[ -z $pid ] && exit

	current_workspace=$(hyprctl activeworkspace -j | jq '.id')	
	hyprctl dispatch movetoworkspacesilent $current_workspace,pid:$pid
}


if [ ! -z $1 ]
then
	if [ "$1" == "h" ]
	then
		hide_window >> /dev/null
	else
		show_window >> /dev/null
	fi
fi

