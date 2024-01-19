#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$1

cd "${impldir}/stevensonmt/brc"
ln -sf "${data_path}" ./measurements.txt
($branchcmd && $timecmd ./run-50M.exs 2>&1) > "${outdir}/stevensonmt.50M.txt"
cd "${owd}"
