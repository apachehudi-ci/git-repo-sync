#!/usr/bin/env bash


# Configuration
SOURCE_REPO=git@github.com:apache/hudi.git
TARGET_REPO=git@github.com:apachehudi-ci/hudi-mirror.git
TARGET_BRANCHES="master"

echo "Syncing branches"
# update last sync file
date > .last-sync


if [ ! -d ".repo" ]; then
	echo "SOURCE_REPO ($SOURCE_REPO) does not exist. Cloning ..."
	git clone --mirror $SOURCE_REPO .repo
fi

cd .repo

echo "Fetching from SOURCE_REPO ($SOURCE_REPO)"
git fetch

for RELEASE_BRANCH in `git branch -a | grep "release-" | sort -V -r | head -n 3` ; do
	TARGET_BRANCHES+=" $RELEASE_BRANCH"
done

echo "Pushing branches '$TARGET_BRANCHES' to TARGET_REPO ($TARGET_REPO)"

# generating refspec
REFSPEC=""
for TARGET_BRANCH in $TARGET_BRANCHES ; do
	REFSPEC+="refs/heads/$TARGET_BRANCH:refs/heads/$TARGET_BRANCH "
done

git push $TARGET_REPO $REFSPEC
