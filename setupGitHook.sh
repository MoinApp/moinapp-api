#! /bin/sh

cat <<EOT > .git/hooks/pre-commit
#! /bin/sh
make all
git add README.md
EOT