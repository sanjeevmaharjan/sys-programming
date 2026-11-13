# System Programming

A C project for system programming exercises and examples.

## Project layout

```text
.
├── Makefile
├── src/               # Application and implementation source files
├── tests/             # GoogleTest tests
└── build/             # Generated build files (not tracked)
```

## Build

Requirements: GNU Make, a C (`C17`) compiler, and GoogleTest with `pkg-config`
for running tests.

```sh
make          # Build the main program and all valid chapter 1 examples
make test     # Build and run the GoogleTest suite
make hw       # Build one chapter 1 example
make clean    # Remove generated build files
```

## Chapter 1 examples

Build a target with `make <target>`, then run its binary from
`build/bin/ch1_intro/`. Examples:

| Make target | Run command / example |
|---|---|
| `hw` | `./build/bin/ch1_intro/hw` |
| `pid` | `./build/bin/ch1_intro/pid` |
| `simple-cat` | `./build/bin/ch1_intro/simple-cat < src/ch01_intro/hw.c` |
| `simple-cat2` | `./build/bin/ch1_intro/simple-cat2 < src/ch01_intro/hw.c` |
| `simple-ls` | `./build/bin/ch1_intro/simple-ls .` |
| `simple-ls-stat` | `./build/bin/ch1_intro/simple-ls-stat src/ch01_intro` |
| `simple-shell` | `printf 'date\n' \| ./build/bin/ch1_intro/simple-shell` (enters `date` at the prompt) |
| `simple-shell2` | `printf 'date\n' \| ./build/bin/ch1_intro/simple-shell2` (enters `date` at the prompt) |
| `welcome-fixed` | `./build/bin/ch1_intro/welcome-fixed` |

> `welcome` is excluded from the default build. Build it on demand with
> `make welcome`. Its source is intentionally erroneous, so compilation will
> fail by design.

To compile the currently open C file in VS Code, run the
**Compile current C file (Debug)** task. From a terminal, use
`make debug-current DEBUG_SOURCE=path/to/file.c`.
