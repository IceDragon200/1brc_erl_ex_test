#!/usr/bin/env bash
source ./common.sh
mkdir -p "${outdir}"
data_path=$1

cd "${impldir}/garazdawi/1brc_erl"
ln -sf "${data_path}" ./measurements.txt
($branchcmd && $timecmd _build/default/bin/erlang_1brc -b aggregate2 -f ./measurements.txt 2>&1) > "${outdir}/garazdawi.1B.txt"
cd "${owd}"
