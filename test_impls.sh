#!/usr/bin/env -S bash -x
source ./common.sh
# In case you want to cleanup between runs
# rm -rf "${outdir}"
./setup.sh
./50M_test.sh
./1B_test.sh
