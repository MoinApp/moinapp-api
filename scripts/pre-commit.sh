#!/bin/sh

git stash -q --keep-index
prmd combine --meta meta.json schemata/ > schema.json
prmd doc schema.json > README.md
make clean all
git add README.md

git stash pop -q
