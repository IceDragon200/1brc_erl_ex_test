#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$(realpath $1)

cd "${impldir}/mnfloresv/1brc-elixir"
ln -sf "${data_path}" ./measurements.txt
(git_metadata && $timecmd mix run --no-mix-exs ./calculate_average.exs 2>&1) > "${outdir}/mnfloresv.1B.txt"
cd "${owd}"
