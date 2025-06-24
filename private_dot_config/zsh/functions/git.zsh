
# GitHub CLI function to delete all failed workflow runs
gh-delete-runs() {
	# Get the IDs of all failed runs
	ids=$(gh run list -s failure --limit=200 --json databaseId -q '.[].databaseId')

	# Loop over the IDs and delete each run
	for id in $ids; do
		gh run delete $id
	done
}


# Generate .gitignore file using Toptal's gitignore API
gi() {
	curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ >.gitignore
}


# Git date manipulation
git-redate() {
	GIT_COMMITTER_DATE="$1" git commit --amend --no-edit --date "$1"
}



function git-deploy() {
	git pull
	git push
	git checkout stage
	git pull
	git merge -X theirs dev
	git push
	git checkout main
	git pull
	git merge -X theirs stage
}
