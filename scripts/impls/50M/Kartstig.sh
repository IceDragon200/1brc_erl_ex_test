#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$(realpath $1)

cd "$impldir/Kartstig/1brc_erl"
ln -sf "${data_path}" ./measurements.txt
(git_metadata && $timecmd ./run.sh ./measurements.txt 2>&1) > "${outdir}/Kartstig.50M.txt"
cd "${owd}"
