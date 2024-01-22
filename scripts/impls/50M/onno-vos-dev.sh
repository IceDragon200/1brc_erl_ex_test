#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$1

# This is not an error, garazdawi's implementation was based off jesperes'
# he left the original aggregate.erl intact so we can run it via his scaffold
cd "${impldir}/onno-vos-dev/1brc"
ln -sf "${data_path}" ./measurements.txt
($branchcmd && $timecmd erl +SDio 1 +SDPcpu 50 +sbwt none +sbwtdio none -pa _build/default/lib/brc/ebin -noshell -s brc run "./measurements.txt" -s init stop  2>&1) > "${outdir}/onno-vos-dev.50M.txt"
cd "${owd}"
