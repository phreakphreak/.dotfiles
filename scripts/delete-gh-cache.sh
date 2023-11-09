#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 REPO BRANCH"
    exit 1
fi

REPO=$1
BRANCH=$2

echo "Fetching list of cache key"
cacheKeysForPR=$(gh actions-cache list -R $REPO -B $BRANCH -L 100 | cut -f 1)

set +e

echo "Deleting caches..."
for cacheKey in $cacheKeysForPR
do
    gh actions-cache delete $cacheKey -R $REPO -B $BRANCH --confirm
done

echo "Done"
