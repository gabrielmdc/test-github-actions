#!/usr/bin/env bash

echo ">>> $1"
BRANCH=$(echo $1 | awk -F "[ ]+" '/feature(s)?\/(major|minor)\/.+/{print $NF}')

if echo BRANCH | grep -q major; then
    # Bump major version
    sh scripts/incr-version.sh --major
elif echo BRANCH | grep -q minor; then
    # Bump minor version
    sh scripts/incr-version.sh --minor
else
    # Bump patch version
    sh scripts/incr-version.sh
fi

