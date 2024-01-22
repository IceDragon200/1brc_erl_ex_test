#!/usr/bin/env -S bash -x
source ./common.sh

echo "Doing some setup"

#
cd "${impldir}/andypho/1brc"
# as of this writing, there are no deps, however we need to resolve the mix file
mix deps.get
mix compile
cat <<__EOF__ > ./run.exs
#!/usr/bin/env -S mix run
OneBrc.calculate_average("./measurements.txt")
__EOF__
chmod +x ./run.exs
cd "${owd}"

#
cd "${impldir}/garazdawi/erlang_1brc"
./setup.sh
cd "${owd}"

#
cd "${impldir}/rparcus/ex_1brc"
mix deps.get
mix compile
cat <<__EOF__ > ./run-with_explorer.exs
#!/usr/bin/env -S mix run
WithExplorer.run()
__EOF__
cat <<__EOF__ > ./run-just_elixir.exs
#!/usr/bin/env -S mix run
JustElixir.run()
__EOF__
cat <<__EOF__ > ./run-better_file_reader.exs
#!/usr/bin/env -S mix run
BetterFileReader.run()
__EOF__
chmod +x ./run-*.exs
cd "${owd}"

#
cd "${impldir}/rrcook/brc"
mix deps.get
mix compile
mix escript.build
cd "${owd}"

cd "${impldir}/stevensonmt/brc"
mix deps.get
mix compile
cat <<__EOF__ > ./run-1B.exs
#!/usr/bin/env -S mix run
Brc.main("./measurements.txt", 1_000_000_000)
__EOF__
cat <<__EOF__ > ./run-50M.exs
#!/usr/bin/env -S mix run
Brc.main("./measurements.txt", 50_000_000)
__EOF__
chmod +x ./run-*.exs
cd "${owd}"

#
cd "${impldir}/onno-vos-dev/1brc"
rebar3 compile
cd "${owd}"