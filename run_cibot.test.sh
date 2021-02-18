#!/usr/bin/env bash

source ${HOME}/.profile

java -jar ${HOME}/ci-bot-test/target/ci-bot.jar \
  --azureToken ${AZURE_TOKEN} \
  --ciRepository 'apachehudi-ci/hudi-branch-ci-test' \
  --githubToken ${GITHUB_TOKEN_TEST} \
  --observedRepository 'xushiyan/hudi' --user hudi-bot --interval 60 --newComment > /dev/null 2>&1 &
