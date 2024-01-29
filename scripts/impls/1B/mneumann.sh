#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$(realpath $1)

cd "$impldir/mneumann/1brc-elixir"
ln -sf "${data_path}" ./measurements.txt
(git_metadata && $timecmd mix run --no-mix-exs ./1brc.exs ./measurements.txt 2>&1) > "${outdir}/mneumann.1B.txt"
cd "${owd}"
