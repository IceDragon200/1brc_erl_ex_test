#!/usr/bin/env bash
source ./common.sh
mkdir -p "${outdir}"

data_1B_path=/data/1brc/measurements.txt

echo "1B Row Test - I hope you ran the 50M test first"

sleep 5
./scripts/impl/1B/andypho.sh "${data_1B_path}"
sleep 5
./scripts/impl/1B/IceDragon200.sh "${data_1B_path}"
sleep 5
./scripts/impl/1B/Kartstig.sh "${data_1B_path}"
sleep 5
./scripts/impl/1B/mnfloresv.sh "${data_1B_path}"
sleep 5
./scripts/impl/1B/rparcus.sh "${data_1B_path}"
sleep 5
./scripts/impl/1B/rrcook.sh "${data_1B_path}"
sleep 5
./scripts/impl/1B/stvensonmt.sh "${data_1B_path}"
