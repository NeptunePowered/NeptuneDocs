#!/usr/bin/env bash

branch=${TRAVIS_PULL_REQUEST}

# Deploy
cd build
git init
git remote add origin git@github.com:LexBot/NeptuneDocs.git
if git ls-remote origin | grep -sw "$branch"
    git fetch origin $branch
    git checkout $branch
else
    git checkout --orphan $branch
fi
git add .
git commit -q -m "Deploy $(date)"
git push -q -f origin gh-pages
echo "Done! Successfully published docs!"
