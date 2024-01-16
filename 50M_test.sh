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
  cd "$impldir/IceDragon200/1brc_ex"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($cmd ./src/1brc.workers.blob.maps.chunk_to_worker.exs 2>&1) > "${outdir}/IceDragon200.50M.txt"
  cd "${owd}"

  sleep 5
  cd "$impldir/Kartstig/1brc_erl"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($cmd ./run.sh ./measurements.txt 2>&1) > "${outdir}/Kartstig.50M.txt"
  cd "${owd}"

  sleep 5
  cd "$impldir/mnfloresv/1brc-elixir"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($cmd ./calculate_average.exs 2>&1) > "${outdir}/mnfloresv.50M.txt"
  cd "${owd}"

  sleep 5
  cd "$impldir/rparcus/ex_1brc"
  ln -sf "${data_50M_path}" ./data/measurements.txt
  ($cmd ./run.exs 2>&1) > "${outdir}/rparcus.50M.txt"
  cd "${owd}"

  sleep 5
  cd "${impldir}/rrcook/brc"
  ln -sf "${data_50M_path}" ./measurements.txt
  ($cmd ./brc "${data_50M_path}" 2>&1) > "${outdir}/rrcook.50M.txt"
  cd "${owd}"
done
