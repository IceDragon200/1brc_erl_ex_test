#!/usr/bin/env bash
source ./common.sh
mkdir -p "${outdir}"

data_1B_path=/data/1brc/measurements.txt

echo "1B Row Test - I hope you ran the 50M test first"

sleep 5
cd "$impldir/andypho/1brc"
ln -sf "${data_1B_path}" ./measurements.txt
($branchcmd && $timecmd ./run.exs 2>&1) > "${outdir}/andypho.1B.txt"
cd "${owd}"

sleep 5
cd "${impldir}/IceDragon200/1brc_ex"
ln -sf "${data_1B_path}" ./measurements.txt
($branchcmd && $timecmd ./src/1brc.workers.blob.maps.chunk_to_worker.exs 2>&1) > "${outdir}/IceDragon200.1B.txt"
cd "${owd}"

sleep 5
cd "${impldir}/Kartstig/1brc_erl"
ln -sf "${data_1B_path}" ./measurements.txt
($branchcmd && $timecmd ./run.sh ./measurements.txt 2>&1) > "${outdir}/Kartstig.1B.txt"
cd "${owd}"

sleep 5
cd "${impldir}/mnfloresv/1brc-elixir"
ln -sf "${data_1B_path}" ./measurements.txt
($branchcmd && $timecmd mix run --no-mix-exs ./calculate_average.exs 2>&1) > "${outdir}/mnfloresv.1B.txt"
cd "${owd}"

sleep 5
cd "${impldir}/rparcus/ex_1brc"
mkdir -p data
ln -sf "${data_1B_path}" ./data/measurements.txt
($branchcmd && $timecmd ./run-with_explorer.exs 2>&1) > "${outdir}/rparcus-with_explorer.1B.txt"
($branchcmd && $timecmd ./run-just_elixir.exs 2>&1) > "${outdir}/rparcus-just_elixir.1B.txt"
($branchcmd && $timecmd ./run-better_file_reader.exs 2>&1) > "${outdir}/rparcus-better_file_reader.1B.txt"
cd "${owd}"

sleep 5
cd "${impldir}/rrcook/brc"
ln -sf "${data_1B_path}" ./measurements.txt
($branchcmd && $timecmd ./brc "${data_1B_path}" 2>&1) > "${outdir}/rrcook.1B.txt"
cd "${owd}"

sleep 5
cd "${impldir}/stevensonmt/brc"
ln -sf "${data_1B_path}" ./measurements.txt
($branchcmd && $timecmd ./run-1B.exs "${data_1B_path}" 2>&1) > "${outdir}/stevensonmt.1B.txt"
cd "${owd}"
