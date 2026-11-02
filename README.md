# System Programming

A C project for system programming exercises and examples.

## Project layout

```text
.
├── CMakeLists.txt
├── src/               # Application and implementation source files
├── tests/             # Tests registered with CTest (unused)
└── build/             # Generated build files (not tracked)
```

## Build

Requirements: CMake (`3.16+`) and a C (`C17`) compiler.

```sh
cmake -S . -B build
cmake --build build # To build all targets
# cmake --build build --target <some_target> # To build single target
```

## Chapter 1 examples

Build a target with `cmake --build build --target <target>`, then run its
binary from `build/bin/ch1_intro/`. Examples:

| CMake target | Run command / example |
|---|---|
| `hw` | `./build/bin/ch1_intro/hw` |
| `pid` | `./build/bin/ch1_intro/pid` |
| `simple-cat` | `./build/bin/ch1_intro/simple-cat < src/ch1_intro/hw.c` |
| `simple-cat2` | `./build/bin/ch1_intro/simple-cat2 < src/ch1_intro/hw.c` |
| `simple-ls` | `./build/bin/ch1_intro/simple-ls .` |
| `simple-ls-stat` | `./build/bin/ch1_intro/simple-ls-stat src/ch1_intro` |
| `simple-shell` | `printf 'date\n' \| ./build/bin/ch1_intro/simple-shell` (enters `date` at the prompt) |
| `simple-shell2` | `printf 'date\n' \| ./build/bin/ch1_intro/simple-shell2` (enters `date` at the prompt) |
| `welcome-fixed` | `./build/bin/ch1_intro/welcome-fixed` |

> `welcome` is excluded from the default build-all. Build it on demand with
> `cmake --build build --target welcome`. Its source is intentionally erroneous,
> so compilation will fail by design.
