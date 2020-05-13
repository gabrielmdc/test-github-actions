#!/usr/bin/env bash

HEAD_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
if [[ "$HEAD_BRANCH" != "master" ]]; then
    echo "Bump the version in the master branch"
    exit 1;
fi

BRANCH=awk -F "[ ]+" '/feature(s)?\/(major|minor)\/.+/{print $NF}'

if echo BRANCH | grep -q major; then
    # Bump major version
    sh scripts/incr-version.sh --major
    return 0
fi

if echo BRANCH | grep -q minor; then
    # Bump minor version
    sh scripts/incr-version.sh --minor
    return 0
fi

# Bump patch version
sh scripts/incr-version.sh
