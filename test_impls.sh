#!/usr/bin/env bash
cmd="/usr/bin/time -v"
out=$(pwd)/out
owd=$(pwd)

rm -rf "${out}"
mkdir -p "${out}"

for x in 0 1; do
  echo "50M Row Test: Run $x (0 is for priming and compilation)"

  sleep 5
  cd IceDragon200/1brc_ex
  ln -sf /data/1brc/measurements_50M.txt ./measurements.txt
  ($cmd ./src/1brc.workers.blob.maps.chunk_to_worker.exs 2>&1) > "${out}/IceDragon200.50M.txt"
  cd "${owd}"

  sleep 5
  cd Kartstig/1brc_erl
  ln -sf /data/1brc/measurements_50M.txt ./measurements.txt
  ($cmd ./run.sh ./measurements.txt 2>&1) > "${out}/Kartstig.50M.txt"
  cd "${owd}"

  sleep 5
  cd mnfloresv/1brc-elixir
  ln -sf /data/1brc/measurements_50M.txt ./measurements.txt
  ($cmd ./calculate_average.exs 2>&1) > "${out}/mnfloresv.50M.txt"
  cd "${owd}"

  sleep 5
  cd rparcus/ex_1brc
  ln -sf /data/1brc/measurements_50M.txt ./data/measurements.txt
  ($cmd ./run.exs 2>&1) > "${out}/rparcus.50M.txt"
  cd "${owd}"
done

echo "1B Row Test"

sleep 5
cd IceDragon200/1brc_ex
ln -sf /data/1brc/measurements.txt ./measurements.txt
($cmd ./src/1brc.workers.blob.maps.chunk_to_worker.exs 2>&1) > "${out}/IceDragon200.1B.txt"
cd "${owd}"

sleep 5
cd Kartstig/1brc_erl
ln -sf /data/1brc/measurements.txt ./measurements.txt
($cmd ./run.sh ./measurements.txt 2>&1) > "${out}/Kartstig.1B.txt"
cd "${owd}"

sleep 5
cd mnfloresv/1brc-elixir
ln -sf /data/1brc/measurements.txt ./measurements.txt
($cmd ./calculate_average.exs 2>&1) > "${out}/mnfloresv.1B.txt"
cd "${owd}"

sleep 5
cd rparcus/ex_1brc
ln -sf /data/1brc/measurements.txt ./data/measurements.txt
($cmd ./run.exs 2>&1) > "${out}/rparcus.1B.txt"
cd "${owd}"
