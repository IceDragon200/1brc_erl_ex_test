#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"

data_50M_path=$(realpath $1)
#
#
#
for x in 0 1; do
  echo "50M Row Test: Run $x (0 is for priming and compilation)"

  sleep 5
  ./scripts/impls/50M/andypho.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/garazdawi.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/jesperes.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/IceDragon200.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/Kartstig.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/mnfloresv.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/rparcus.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/rrcook.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/stevensonmt.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/onno-vos-dev.sh "${data_50M_path}"
  sleep 5
  ./scripts/impls/50M/mneumann.sh "${data_50M_path}"
done
