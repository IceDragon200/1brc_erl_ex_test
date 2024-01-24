#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$(realpath $1)

cd "${impldir}/stevensonmt/brc"
ln -sf "${data_path}" ./measurements.txt
($branchcmd && $timecmd ./run-1B.exs "${data_1B_path}" 2>&1) > "${outdir}/stevensonmt.1B.txt"
cd "${owd}"
