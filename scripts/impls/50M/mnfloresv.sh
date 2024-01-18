#!/usr/bin/env bash
source ./common.sh
mkdir -p "${outdir}"
data_path=$1

cd "$impldir/mnfloresv/1brc-elixir"
ln -sf "${data_path}" ./measurements.txt
($branchcmd && $timecmd mix run --no-mix-exs ./calculate_average.exs 2>&1) > "${outdir}/mnfloresv.50M.txt"
cd "${owd}"
