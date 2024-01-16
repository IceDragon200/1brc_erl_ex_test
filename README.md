# Elixir & Erlang 1BRC Challenge Test scaffolding

tl;dr
```bash
./test_impls.sh
```

## Installation

```bash
git clone --recurse-submodules -j$(nproc) https://github.com/IceDragon200/1brc_erl_ex
```

Some implementations may require additional setup:
```bash
cd 1brc_erl_ex
./setup.sh
```

## Running it

```bash
# This can do everything you need all at once
./test_impls.sh
```

But you can also run the individual tests:

```bash
# The 50 million line test is a good place to start before you jump into 1B
./test_50M_test.sh

# You can then run the big boy, beware as some implementations may require at least 12Gb of RAM
./test_1B_test.sh
```
