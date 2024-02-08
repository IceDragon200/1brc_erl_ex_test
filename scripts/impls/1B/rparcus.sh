#!/usr/bin/env -S bash -x
source ./common.sh
mkdir -p "${outdir}"
data_path=$(realpath $1)

cd "${impldir}/rparcus/ex_1brc"
mkdir -p data
ln -sf "${data_path}" ./data/measurements.txt
(git_metadata && $timecmd ./run-with_explorer.exs 2>&1) > "${outdir}/rparcus-with_explorer.1B.txt"
(git_metadata && $timecmd ./run-just_elixir.exs 2>&1) > "${outdir}/rparcus-just_elixir.1B.txt"
(git_metadata && $timecmd ./run-better_file_reader.exs 2>&1) > "${outdir}/rparcus-better_file_reader.1B.txt"
(git_metadata && $timecmd ./run-runtime_compiled.exs 2>&1) > "${outdir}/rparcus-runtime_compiled.1B.txt"
cd "${owd}"
