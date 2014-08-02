#!/bin/sh

cat <<EOT > .git/hooks/pre-commit
#! /bin/sh
pwd
make clean all
git add README.md
EOT

chmod +x .git/hooks/pre-commit
