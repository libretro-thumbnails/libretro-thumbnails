#!/usr/bin/env bash

thumbdir=$(pwd)
for d in */
do
    echo ----
	echo "$d"
    echo ----
    cd "$thumbdir"/"$d"
    git rev-parse --verify main 2>/dev/null
    retVal=$?
    if [ $retVal -ne 0 ]; then
        git checkout master
        git pull origin master --depth=20
    else
        git checkout main
        git pull origin main --depth=20
    fi
    [[ $1 = "gc" ]] && git gc --prune=all
done
