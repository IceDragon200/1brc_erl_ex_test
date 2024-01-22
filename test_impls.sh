#!/usr/bin/env -S bash -x
source ./common.sh
FIFTY_MILLION_FILE=/data/1brc/measurements_50M.txt
if [ "$1" != "" ]; then
    FIFTY_MILLION_FILE=$(realpath $1)
fi
ONE_BILLION_FILE="/data/1brc/measurements.txt"
if [ "$2" != "" ]; then
    ONE_BILLION_FILE=$(realpath $2)
fi
# In case you want to cleanup between runs
# rm -rf "${outdir}"
./setup.sh
./50M_test.sh "$FIFTY_MILLION_FILE"
./1B_test.sh "$ONE_BILLION_FILE"
