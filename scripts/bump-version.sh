#!/usr/bin/env bash

BRANCH=$(echo $1 | awk -F "[ ]+" '/feature(s)?\/(major|minor)\/.+/{print $NF}')

if echo BRANCH | grep -q major; then
    # Bump major version
    scripts/incr-version.sh --major
elif echo BRANCH | grep -q minor; then
    # Bump minor version
    scripts/incr-version.sh --minor
else
    # Bump patch version
    scripts/incr-version.sh
fi

