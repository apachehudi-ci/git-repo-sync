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
	git init --bare .repo
	cd .repo
	git remote add origin $SOURCE_REPO
else
	cd .repo
fi

# Fetch master and release branches with proper refspecs
echo "Fetching master and release branches from SOURCE_REPO ($SOURCE_REPO)"
git fetch --depth=100 origin '+refs/heads/master:refs/heads/master' '+refs/heads/release-*:refs/heads/release-*'

# Build target branch list (use git branch without -a for local refs)
for RELEASE_BRANCH in `git branch | sed 's|^[ *]*||' | grep "release-" | sort -V -r | head -n 4` ; do
	TARGET_BRANCHES+=" $RELEASE_BRANCH"
done

echo "Pushing branches '$TARGET_BRANCHES' to TARGET_REPO ($TARGET_REPO)"

# generating refspec
REFSPEC=""
for TARGET_BRANCH in $TARGET_BRANCHES ; do
	REFSPEC+="refs/heads/$TARGET_BRANCH:refs/heads/$TARGET_BRANCH "
done

git push -f $TARGET_REPO $REFSPEC
