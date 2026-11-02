cmake_minimum_required(VERSION 3.16)

project(sys_programming
    VERSION 1.0.0
    DESCRIPTION "System programming exercises and examples"
    LANGUAGES C
)

set(DEBUG_SOURCE "" CACHE FILEPATH "C source file to build as the debug_current target")

add_executable(sys_programming
    src/main.c
)

function(configure_c_target target)
    target_compile_features(${target} PRIVATE c_std_17)
    set_target_properties(${target} PROPERTIES C_EXTENSIONS OFF)

    if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
        target_compile_options(${target} PRIVATE -Wall -Wextra -Wpedantic)
    elseif(MSVC)
        target_compile_options(${target} PRIVATE /W4)
    endif()
endfunction()

configure_c_target(sys_programming)
target_include_directories(sys_programming PRIVATE "${PROJECT_SOURCE_DIR}/include")

if(DEBUG_SOURCE)
    if(NOT EXISTS "${DEBUG_SOURCE}")
        message(FATAL_ERROR "DEBUG_SOURCE does not exist: ${DEBUG_SOURCE}")
    endif()

    add_executable(debug_current "${DEBUG_SOURCE}")
    configure_c_target(debug_current)
    target_compile_definitions(debug_current PRIVATE _POSIX_C_SOURCE=200809L)
    target_include_directories(debug_current PRIVATE "${PROJECT_SOURCE_DIR}/include")
    set_target_properties(debug_current PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin/debug"
        RUNTIME_OUTPUT_DIRECTORY_DEBUG "${PROJECT_BINARY_DIR}/bin/debug"
    )
endif()

function(add_ch1_example target source)
    add_executable(${target} "${source}")
    configure_c_target(${target})
    target_compile_definitions(${target} PRIVATE _POSIX_C_SOURCE=200809L)
    set_target_properties(${target} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin/ch1_intro"
    )
endfunction()

if(UNIX)
    add_ch1_example(hw src/ch1_intro/hw.c)
    add_ch1_example(pid src/ch1_intro/pid.c)
    add_ch1_example(simple-cat src/ch1_intro/simple-cat.c)
    add_ch1_example(simple-cat2 src/ch1_intro/simple-cat2.c)
    add_ch1_example(simple-ls src/ch1_intro/simple-ls.c)
    add_ch1_example(simple-ls-stat src/ch1_intro/simple-ls-stat.c)
    add_ch1_example(simple-shell src/ch1_intro/simple-shell.c)
    add_ch1_example(simple-shell2 src/ch1_intro/simple-shell2.c)
    add_executable(welcome EXCLUDE_FROM_ALL src/ch1_intro/welcome.c)
    configure_c_target(welcome)
    target_compile_definitions(welcome PRIVATE _POSIX_C_SOURCE=200809L)
    set_target_properties(welcome PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin/ch1_intro"
    )
    add_ch1_example(welcome-fixed src/ch1_intro/welcome-fixed.c)
else()
    message(STATUS "Skipping ch1_intro examples: they require a POSIX platform")
endif()

include(CTest)
if(BUILD_TESTING)
    add_test(NAME sys_programming_starts COMMAND sys_programming)
endif()
