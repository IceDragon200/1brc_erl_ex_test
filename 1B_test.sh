#!/usr/bin/env bash
source ./common.sh
mkdir -p "${outdir}"

data_1B_path=/data/1brc/measurements.txt

echo "1B Row Test - I hope you ran the 50M test first"

sleep 5
cd $impldir/IceDragon200/1brc_ex
ln -sf "${data_1B_path}" ./measurements.txt
($cmd ./src/1brc.workers.blob.maps.chunk_to_worker.exs 2>&1) > "${outdir}/IceDragon200.1B.txt"
cd "${owd}"

sleep 5
cd $impldir/Kartstig/1brc_erl
ln -sf "${data_1B_path}" ./measurements.txt
($cmd ./run.sh ./measurements.txt 2>&1) > "${outdir}/Kartstig.1B.txt"
cd "${owd}"

sleep 5
cd $impldir/mnfloresv/1brc-elixir
ln -sf "${data_1B_path}" ./measurements.txt
($cmd ./calculate_average.exs 2>&1) > "${outdir}/mnfloresv.1B.txt"
cd "${owd}"

sleep 5
cd $impldir/rparcus/ex_1brc
ln -sf "${data_1B_path}" ./data/measurements.txt
($cmd ./run.exs 2>&1) > "${outdir}/rparcus.1B.txt"
cd "${owd}"

sleep 5
cd $impldir/rrcook/brc
ln -sf "${data_1B_path}" ./measurements.txt
($cmd ./brc "${data_1B_path}" 2>&1) > "${outdir}/rrcook.1B.txt"
cd "${owd}"
