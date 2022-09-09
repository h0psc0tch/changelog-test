#!/bin/bash


if [ "main" != "$(git branch --show-current)" ]; then
  echo "cannot generate changelog outside of main"
  exit
fi

# We need two SHAs to perform generate the changelog
if [ -z "$1" ] || [ -z "$2" ]; then

  # If either SHA is missing, create a standard message to add to the slack message
  # The most likely reason for a missing SHA is that one has not been stored by the prod deployment
  printf "Missing SHA\n"
  printf 'Prod SHA: %s\n' "$1"
  printf 'Staging SHA: %s\n' "$2"
fi

URLPREFIX=https://github.com/h0psc0tch/changelog-test/commit/

echo "Prod SHA: $1"
echo "Stag SHA: $2"
echo "Commits included in release:"
git log --ancestry-path $1..$2 --date=format:"%Y-%m-%d %H:%M" --pretty=format:">%ad *%an* <$URLPREFIX%H|%s>" | sed 's/"//g'