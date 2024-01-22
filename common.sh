#!/usr/bin/env bas

if [ "$(uname)" == "Darwin" ]; then
  timecmd="gtime -v"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  timecmd="/usr/bin/time -v"
else
  echo "Only Linux and Mac supported at this time"
  exit 1
fi

branchcmd="git branch -v"
outdir=$(pwd)/out
owd=$(pwd)
impldir=$(pwd)/impls
