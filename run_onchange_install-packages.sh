#!/bin/sh

git -S $CHEZMOI_WORKING_TREE config --local user.name "🤖 automated"
git -S $CHEZMOI_WORKING_TREE config --local user.email "cron@job"
