CC ?= cc
CXX ?= c++
CPPFLAGS ?=
CFLAGS ?= -std=c17 -Wall -Wextra -Wpedantic
CXXFLAGS ?= -std=c++17 -Wall -Wextra -Wpedantic

BUILD_DIR := build
CH1_DIR := $(BUILD_DIR)/bin/ch1_intro
DEBUG_DIR := $(BUILD_DIR)/bin/debug
CH1_TARGETS := hw pid simple-cat simple-cat2 simple-ls simple-ls-stat \
	simple-shell simple-shell2 welcome-fixed
CH1_BINARIES := $(addprefix $(CH1_DIR)/,$(CH1_TARGETS))
GTEST_CXXFLAGS ?= $(shell pkg-config --cflags gtest 2>/dev/null)
GTEST_LIBS ?= $(shell pkg-config --libs gtest_main 2>/dev/null)

.PHONY: all build test clean debug-current welcome $(CH1_TARGETS)

all: $(BUILD_DIR)/sys_programming $(CH1_BINARIES)

build: all

$(BUILD_DIR)/sys_programming: src/main.c
	mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) $< -o $@

$(CH1_DIR)/%: src/ch01_intro/%.c
	mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -D_POSIX_C_SOURCE=200809L $< -o $@

$(CH1_TARGETS): %: $(CH1_DIR)/%

welcome: $(CH1_DIR)/welcome

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
