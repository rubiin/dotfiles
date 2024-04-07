#!/bin/sh

#Workspace 1: terminal workspace.
#Workspace 2: browser workspace.
#Workspace 3: ide workspace.
#Workspace 4: files workspace 
#Workspace 5: Media and Entertainment Workspace
#Workspace 6: System Monitoring and Utilities 
#Workspace 7: Misc 

# Define the mappings of applications to their designated workspaces
declare -A app_workspace_mapping=(
    ["kitty"]="1"
    ["Alacritty"]="1"
    ["Vivaldi-stable"]="2"
    ["firefox"]="2"
    ["chrome"]="2"
    ["vlc"]="5"
    ["mpv"]="5"
    ["org.kde.dolphin"]="4"
    ["org.kde.ktorrent"]="4"
)

# Function to move application windows to their designated workspaces
move_app_to_workspace() {
    workspace=${app_workspace_mapping[$1]}
    hyprctl dispatch movetoworkspacesilent $workspace,$1
}

echo "Starting hyperlanding script..."

#start vivaldi
kitty & disown
vivaldi & disown
sleep 2

#!/bin/bash
for class in $(hyprctl -j clients | jq -r ".[].class" | sort -u)
do
    move_app_to_workspace $class
done
