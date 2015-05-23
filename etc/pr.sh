#!/usr/bin/env bash

branch=${TRAVIS_PULL_REQUEST}
echo "Deploying PR #$branch"

# Deploy
cd build
git init
git remote add origin git@github.com:LexBot/NeptuneDocs.git
if git ls-remote origin | grep -sw "$branch"; then
    git fetch origin $branch
    git checkout $branch
else
    git checkout --orphan $branch
fi
git add .
git commit -q -m "Deploy $(date)"
git push -q -f origin $branch
echo "Done! Successfully published docs!"
cd ../

# Give time for GitHub API to catch up
sleep 5

# Make comment
#python ./etc/comment.py
