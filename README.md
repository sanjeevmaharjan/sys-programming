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
make          # Build the main program and all chapter 1 and 5 examples
make test     # Build and run the GoogleTest suite
make ch01-hw  # Build one chapter 1 example
make ch05-argv # Build one chapter 5 example
make clean    # Remove generated build files
```

## Chapter 1 examples

Build a target with `make <target>`, then run its binary from
`build/bin/ch1_intro/`. Examples:

| Make target | Run command / example |
|---|---|
| `ch01-hw` | `./build/bin/ch1_intro/hw` |
| `ch01-pid` | `./build/bin/ch1_intro/pid` |
| `ch01-simple-cat` | `./build/bin/ch1_intro/simple-cat < src/ch01_intro/hw.c` |
| `ch01-simple-cat2` | `./build/bin/ch1_intro/simple-cat2 < src/ch01_intro/hw.c` |
| `ch01-simple-ls` | `./build/bin/ch1_intro/simple-ls .` |
| `ch01-simple-ls-stat` | `./build/bin/ch1_intro/simple-ls-stat src/ch01_intro` |
| `ch01-simple-shell` | `printf 'date\n' \| ./build/bin/ch1_intro/simple-shell` (enters `date` at the prompt) |
| `ch01-simple-shell2` | `printf 'date\n' \| ./build/bin/ch1_intro/simple-shell2` (enters `date` at the prompt) |
| `ch01-welcome-fixed` | `./build/bin/ch1_intro/welcome-fixed` |

> `ch01-welcome` is excluded from the default build. Build it on demand with
> `make ch01-welcome`. Its source is intentionally erroneous, so compilation
> will fail by design.

## Chapter 5 examples

Build a target with `make <target>`, then run its binary from
`build/bin/ch05_process/`. Examples:

| Make target | Run command / example |
|---|---|
| `ch05-hw` | `./build/bin/ch05_process/hw` |
| `ch05-argv` | `./build/bin/ch05_process/argv *.c` (shows how the shell expands arguments) |
| `ch05-entry` | `./build/bin/ch05_process/entry` |
| `ch05-exit-handlers` | `./build/bin/ch05_process/exit-handlers` |
| `ch05-forkflush` | `./build/bin/ch05_process/forkflush` or `./build/bin/ch05_process/forkflush \| cat` |
| `ch05-memory-layout` | `./build/bin/ch05_process/memory-layout` |
| `ch05-zombies` | `./build/bin/ch05_process/zombies` |

`exit-handlers` also demonstrates the effect of calling `exit()` or `_exit()`
with one or two command-line arguments. `zombies` creates short-lived child
processes, displays each child's state (`Z` indicates a zombie), and takes
about 20 seconds to finish.

To compile the currently open C file in VS Code, run the
**Compile current C file (Debug)** task. From a terminal, use
`make debug-current DEBUG_SOURCE=path/to/file.c`.
