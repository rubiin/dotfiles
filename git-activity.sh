#!/bin/bash

####
## Use for demo purposes only!
## To execute just run the following commaind inside a demo repository:
#
# wget https://raw.githubusercontent.com/bobbyiliev/github-activity-bash-script/main/activity.sh
# bash activity.sh
# # Finllly push your changes to GitHub:
# git push origin -f your_branch_name"
####

##
# Create temp commits direcotry
##
if [[ ! -d .commits ]] ; then
    mkdir -p .commits
fi
##
# Add changes file log
##
if [[ ! -f  .commits/changes ]] ; then
    touch .commits/changes
    git add .
fi

##
# Create commits for the past 365 days
##
for day in {1..365} ; do
    # Get the past date of the commit
    day=$(date --date="-${day} day")

    echo "Creating commits for ${day}"

    # Generate random number of commits for that date
    commits=$(( ( RANDOM % 6 )  + 2 ))

    # Create the comits
    echo "Creating ${commits} commits"
    for ((i=1;i<=6000;i++)); do
        content=$(date -d "$day" +"%s")
        echo ${content}-${i} >> .commits/changes
        git commit -am "Commit number ${content}-${i}" > /dev/null 2>&1
        git commit --amend --no-edit --date "${day}" > /dev/null 2>&1
    done
done

echo "Generating commits completed..."
echo "To push your commits run:"
echo "git push origin -f your_branch_name"
