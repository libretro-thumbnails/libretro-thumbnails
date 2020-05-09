#!/usr/bin/env bash

thumbdir=$(pwd)
for d in */
do
    echo ----
	echo "$d"
    echo ----
    cd "$thumbdir"/"$d"
    git checkout master
    git pull origin master --depth=20
    [[ $1 = "gc" ]] && git gc --prune=all
done
