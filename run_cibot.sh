#!/usr/bin/env bash

source ${HOME}/.profile

java -jar ${HOME}/ci-bot/target/ci-bot.jar \
  --azureToken ${AZURE_TOKEN} \
  --ciRepository 'apachehudi-ci/hudi-branch-ci' \
  --githubToken ${GITHUB_TOKEN} \
  --observedRepository 'apache/hudi' --user hudi-bot --interval 60 --newComment > /dev/null 2>&1 &
