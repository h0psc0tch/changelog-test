#!/bin/bash


if [ "main" != "$(git branch --show-current)" ]; then
  echo "cannot generate changelog outside of main"
  exit
fi

if [ -z "$1" ]; then
  echo "no prod SHA supplied"
  exit
fi

if [ -z "$2" ]; then
  echo "no staging SHA supplied"
  exit
fi

URLPREFIX=https://github.com/h0psc0tch/changelog-test/commit/

echo "Prod SHA: $1"
echo "Stag SHA: $2"
echo "Commits included in release:"
git log --ancestry-path $1..$2 --date=format:"%Y-%m-%d %H:%M" --pretty=format:">%ad *%an* <$URLPREFIX%H|%s>" | sed 's/"//g'