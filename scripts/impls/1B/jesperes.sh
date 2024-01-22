#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$1

# This is not an error, garazdawi's implementation was based off jesperes'
# he left the original aggregate.erl intact so we can run it via his scaffold
cd "${impldir}/garazdawi/erlang_1brc"
ln -sf "${data_path}" ./measurements.txt
($branchcmd && $timecmd ./run.sh ./measurements.txt "aggregate" 2>&1) > "${outdir}/jesperes.1B.txt"
cd "${owd}"
