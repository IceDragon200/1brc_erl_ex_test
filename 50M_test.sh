#!/usr/bin/env bash
source ./common.sh
mkdir -p "${outdir}"

data_50M_path=/data/1brc/measurements_50M.txt
#
#
#
for x in 0 1; do
  echo "50M Row Test: Run $x (0 is for priming and compilation)"

  sleep 5
  cd "$impldir/andypho/1brc"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($branchcmd && $timecmd ./run.exs 2>&1) > "${outdir}/andypho.50M.txt"
  cd "${owd}"

  sleep 5
  cd "$impldir/IceDragon200/1brc_ex"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($branchcmd && $timecmd ./src/1brc.workers.blob.maps.chunk_to_worker.exs 2>&1) > "${outdir}/IceDragon200.50M.txt"
  cd "${owd}"

  sleep 5
  cd "$impldir/Kartstig/1brc_erl"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($branchcmd && $timecmd ./run.sh ./measurements.txt 2>&1) > "${outdir}/Kartstig.50M.txt"
  cd "${owd}"

  sleep 5
  cd "$impldir/mnfloresv/1brc-elixir"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($branchcmd && $timecmd ./calculate_average.exs 2>&1) > "${outdir}/mnfloresv.50M.txt"
  cd "${owd}"

  sleep 5
  cd "$impldir/rparcus/ex_1brc"
  ln -sf "${data_50M_path}" ./data/measurements.txt
  ($branchcmd && $timecmd ./run-with_explorer.exs 2>&1) > "${outdir}/rparcus-with_explorer.50M.txt"
  ($branchcmd && $timecmd ./run-just_elixir.exs 2>&1) > "${outdir}/rparcus-just_elixir.50M.txt"
  ($branchcmd && $timecmd ./run-better_file_reader.exs 2>&1) > "${outdir}/rparcus-better_file_reader.50M.txt"
  cd "${owd}"

  sleep 5
  cd "${impldir}/rrcook/brc"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($branchcmd && $timecmd ./run.exs "${data_50M_path}" 2>&1) > "${outdir}/rrcook.50M.txt"
  cd "${owd}"

  sleep 5
  cd "${impldir}/stevensonmt/brc"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($branchcmd && $timecmd ./run-50M.exs "${data_50M_path}" 2>&1) > "${outdir}/stevensonmt.50M.txt"
  cd "${owd}"
done
