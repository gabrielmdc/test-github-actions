#!/usr/bin/env bash

echo ">>> $1"
BRANCH=$(echo $1 | awk -F "[ ]+" '/feature(s)?\/(major|minor)\/.+/{print $NF}')

if echo BRANCH | grep -q major; then
    # Bump major version
    sh incr-version.sh --major
elif echo BRANCH | grep -q minor; then
    # Bump minor version
    sh incr-version.sh --minor
else
    # Bump patch version
    sh incr-version.sh
fi

