#!/bin/sh

git stash -q --keep-index
prmd combine --meta meta.json schemata/ > $(shell pwd)/schema.json
prmd doc $(shell pwd)/schema.json > $(shell pwd)/README.md
make clean all
git add README.md

git stash pop -q
