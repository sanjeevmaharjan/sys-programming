CC ?= cc
CXX ?= c++
CPPFLAGS ?=
CFLAGS ?= -std=c17 -Wall -Wextra -Wpedantic
CXXFLAGS ?= -std=c++17 -Wall -Wextra -Wpedantic

BUILD_DIR := build
CH1_DIR := $(BUILD_DIR)/bin/ch1_intro
CH5_DIR := $(BUILD_DIR)/bin/ch05_process
DEBUG_DIR := $(BUILD_DIR)/bin/debug
CH1_TARGETS := ch01-hw ch01-pid ch01-simple-cat ch01-simple-cat2 \
	ch01-simple-ls ch01-simple-ls-stat ch01-simple-shell ch01-simple-shell2 \
	ch01-welcome-fixed
CH1_BINARIES := $(patsubst ch01-%, $(CH1_DIR)/%, $(CH1_TARGETS))
CH5_TARGETS := ch05-hw ch05-argv ch05-entry ch05-exit-handlers \
	ch05-forkflush ch05-memory-layout ch05-zombies
CH5_BINARIES := $(patsubst ch05-%, $(CH5_DIR)/%, $(CH5_TARGETS))
GTEST_CXXFLAGS ?= $(shell pkg-config --cflags gtest 2>/dev/null)
GTEST_LIBS ?= $(shell pkg-config --libs gtest_main 2>/dev/null)

.PHONY: all build test clean debug-current ch01-welcome $(CH1_TARGETS) $(CH5_TARGETS)

all: $(BUILD_DIR)/sys_programming $(CH1_BINARIES) $(CH5_BINARIES)

build: all

$(BUILD_DIR)/sys_programming: src/main.c
	mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) $< -o $@

$(CH1_DIR)/%: src/ch01_intro/%.c
	mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -D_POSIX_C_SOURCE=200809L $< -o $@

$(CH1_TARGETS): ch01-%: $(CH1_DIR)/%

$(CH5_DIR)/%: src/ch05_process/%.c
	mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -D_POSIX_C_SOURCE=200809L $< -o $@

$(CH5_TARGETS): ch05-%: $(CH5_DIR)/%

ch01-welcome: $(CH1_DIR)/welcome

$(BUILD_DIR)/tests/sys_programming_test: tests/sys_programming_test.cpp $(BUILD_DIR)/sys_programming
	mkdir -p $(@D)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(GTEST_CXXFLAGS) $< $(GTEST_LIBS) -o $@

test: $(BUILD_DIR)/tests/sys_programming_test
	./$(BUILD_DIR)/tests/sys_programming_test

debug-current:
	@test -n "$(DEBUG_SOURCE)" || { echo "Usage: make debug-current DEBUG_SOURCE=<C source file>" >&2; exit 2; }
	mkdir -p $(DEBUG_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -g -D_POSIX_C_SOURCE=200809L "$(DEBUG_SOURCE)" -o $(DEBUG_DIR)/debug_current

clean:
	rm -rf $(BUILD_DIR)
