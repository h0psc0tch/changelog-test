#!/bin/bash

if [ "main" != $(git branch --show-current) ]; then
  echo "cannot generate changelog outside of main"
  git rev-parse --abbrev-ref HEAD
  git branch --show-current
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

echo "Commits included in release:"
git log --ancestry-path $1..$2 --date=format:"%Y-%m-%d %H:%M" --pretty=format:">%ad *%an* <https://github.com/Walkinltd/backend/commit/%H|%s>" | sed 's/"//g'