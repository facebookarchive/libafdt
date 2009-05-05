#!/bin/sh
set -e

COMMIT="master"
test "$#" -gt 0 && COMMIT="$1"

HASH=`git rev-parse "$COMMIT"`
NOW=`date`

CURRENT=`git symbolic-ref HEAD | sed s:^refs/heads/::`

if { git ls-files --modified ; git diff --name-only HEAD ; } | grep . >/dev/null ; then
  echo >&2 "Cannot regenerate documentation with uncommitted changes."
  exit 1
fi

git checkout "$HASH"
rm -rf doxygen-out index.html
doxygen Doxyfile
rst2html README.rst > index-html

git checkout "$CURRENT"
test -d doxygen && git rm -r doxygen
rm -rf doxygen
mv doxygen-out/html doxygen
rm -rf doxygen-out
mv index-html index.html
git add doxygen index.html

rm -f doxygen-commit-message
cat >>doxygen-commit-message <<EOF
Regenerating docs from $COMMIT

$HASH at $NOW
EOF
git commit -F doxygen-commit-message
rm -f doxygen-commit-message
