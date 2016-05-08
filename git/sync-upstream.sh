#!/bin/bash

pushd fabric
git fetch upstream
git checkout master
git rebase upstream/master
git checkout devel
git rebase upstream/master
git checkout devel
popd
