#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo
# hugo -t timeline # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Setting for submodule commit
git config --local user.name "minkj1992"
git config --local user.email "minkj1992@gmail.com"
git submodule update --init --recursive

# Add changes to git.

git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..

# blog 저장소 Commit & Push
git add .

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin master