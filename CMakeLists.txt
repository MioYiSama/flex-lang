cmake_minimum_required(VERSION 4.1)
project(flex-lang CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(INSTALL_DIR ${CMAKE_BINARY_DIR}/install)

add_executable(flex)
target_sources(flex PRIVATE
        src/main.cpp
)

# Antlr4 Runtime
add_subdirectory(lib/antlr4/runtime/Cpp)
target_link_libraries(flex PRIVATE antlr4_static)

# Antlr4 Grammar
include(lib/antlr4.cmake)
target_sources(flex PRIVATE ${GRAMMAR_SOURCE_FILE})

# TinyCC
include(lib/tinycc.cmake)
target_link_libraries(flex PRIVATE ${TINYCC_LIBRARY})

# Install Dir
target_include_directories(flex PRIVATE ${INSTALL_DIR}/include)
target_link_directories(flex PRIVATE ${INSTALL_DIR}/lib)
