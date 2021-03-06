#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SOURCE="${0%/*}"

YAML="$SOURCE/doxygen.yml"
DOXYDIR="$SOURCE/doxygen"
TRAVIS=".travis.yml"

git checkout -b doxygen master

cp -v "$YAML" "$TRAVIS"
cp -v "$DOXYDIR/gitignore" .gitignore
cp -v "$DOXYDIR"/*.inc .
cp -v "$DOXYDIR/doxygen/"* doxygen

git apply "$DOXYDIR/doxygen-extras.patch"

git add -f "$TRAVIS" doxygen *.inc mutt/mutt.h email/email.h Makefile.autosetup .gitignore
git commit -m "travis: add doxygen config"
git log --oneline -n1

