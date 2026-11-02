# System Programming

A C17 project for system programming exercises and examples.

## Project layout

```text
.
├── CMakeLists.txt
├── include/
│   └── sysprog/       # Public headers, grouped by topic
├── src/               # Application and implementation source files
├── tests/             # Tests registered with CTest
└── build/             # Generated build files (not tracked)
```

As the project grows, organize source and headers by topic, such as processes,
files, memory, or threads.

## Build

Requirements: CMake 3.16+ and a C17 compiler.

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
