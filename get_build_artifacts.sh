#!/bin/bash
curl \
-H "Authorization: token $GITHUB_TOKEN" \
-H "Accept: application/octet-stream" \
-LJO "$(curl https://api.github.com/repos/$TRAVIS_REPO_SLUG/releases/tags/$TRAVIS_PULL_REQUEST_BRANCH?access_token=$GITHUB_TOKEN | grep "assets/.*" | cut -d '"' -f 4)"