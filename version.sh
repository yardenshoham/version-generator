#!/bin/bash

set -e

currentDate=$(date +%Y.%m.%d)

baseTag="${currentDate}-${GITHUB_RUN_ATTEMPT}"

# Check if on master branch
if [[ "$GITHUB_REF_NAME" == "master" ]]; then
    echo "$baseTag"
    exit 0
fi

# Check if on a release branch
if [[ "$GITHUB_REF_NAME" =~ ^release/[0-9]+\.[0-9]+$ ]]; then
    releaseVersion=$(echo "$GITHUB_REF_NAME" | cut -d '/' -f 2)
    echo "${releaseVersion}.${GITHUB_RUN_ATTEMPT}"
    exit 0
fi

# Handle side branch
branch=$(echo "$GITHUB_REF_NAME" | sed 's/[/_+()]//g' | tr '/' '-')
echo "${baseTag}.${branch}"