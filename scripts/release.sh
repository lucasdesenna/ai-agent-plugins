#!/usr/bin/env bash

version=${1:"0.1.0"}
release_dir="/tmp/ai-agent-plugins-release"

git worktree add $release_dir -B release origin/release

rsync -a --delete --exclude=.git dist/ $release_dir

git -C $release_dir add -A
git -C $release_dir commit -a -m "release: $version"
git -C $release_dir push origin release

git worktree remove $release_dir
rm -rf $release_dir