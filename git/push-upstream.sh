#!/bin/bash

pushd ../../fabric
git checkout master
git push
git checkout devel
git push
git checkout devel
popd
