#!/bin/sh

git stash -q --keep-index
make clean all
git add README.md
git stash pop -q
