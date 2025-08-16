cmake_minimum_required(VERSION 4.1)
project(flex-lang CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(flex)
target_sources(flex PRIVATE
        src/main.cpp
)

set(INSTALL_DIR ${CMAKE_BINARY_DIR}/install)
target_include_directories(flex PRIVATE ${INSTALL_DIR}/include)
target_link_directories(flex PRIVATE ${INSTALL_DIR}/lib)

add_subdirectory(lib/antlr4/runtime/Cpp)
target_link_libraries(flex PRIVATE antlr4_static)

include(lib/tinycc.cmake)
target_link_libraries(flex PRIVATE ${TINYCC_LIBRARY})
