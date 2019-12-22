#!/usr/bin/env sh

REPO_DIR="/pub/git"

for repo in $(find /pub/git -maxdepth 2 -type d -iname '*.git'); do
        (cd $repo
        git config --get remote.origin.mirror > /dev/null
        if [ $? -eq 0 ]; then
                echo "Updating mirror at $repo"
                git remote update > /dev/null
        fi)
done


