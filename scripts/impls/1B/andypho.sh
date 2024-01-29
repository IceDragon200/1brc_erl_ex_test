#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$(realpath $1)

cd "$impldir/andypho/1brc"
ln -sf "${data_path}" ./measurements.txt
(git_metadata && $timecmd ./run.exs 2>&1) > "${outdir}/andypho.1B.txt"
cd "${owd}"
