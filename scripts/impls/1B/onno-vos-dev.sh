#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$(realpath $1)

cd "${impldir}/onno-vos-dev/1brc"
ln -sf "${data_path}" ./measurements.txt
(git_metadata && $timecmd erl +SDio 1 +SDPcpu 50 +sbwt none +sbwtdio none -noshell -s brc run "./measurements.txt" -s init stop  2>&1) > "${outdir}/onno-vos-dev.1B.txt"
cd "${owd}"
