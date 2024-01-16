#!/usr/bin/env bash
source ./common.sh

echo "Doing some setup"

#
cd "${impldir}/rparcus/ex_1brc"
mix deps.get
mix compile
cd "${owd}"

#
cd "${impldir}/rrcook/brc"
mix deps.get
mix compile
mix escript.build
cd "${owd}"
