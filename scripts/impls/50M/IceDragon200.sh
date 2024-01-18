#!/usr/bin/env bash
source ./common.sh
mkdir -p "${outdir}"
data_path=$1

cd "$impldir/IceDragon200/1brc_ex"
ln -sf "${data_path}" ./measurements.txt
($branchcmd && $timecmd ./src/1brc.workers.blob.maps.chunk_to_worker.exs 2>&1) > "${outdir}/IceDragon200.50M.txt"
cd "${owd}"
