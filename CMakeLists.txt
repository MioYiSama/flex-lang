cmake_minimum_required(VERSION 4.1)
project(flex-lang CXX)

set(CMAKE_CXX_STANDARD 23)

add_executable(flex)
target_sources(flex PRIVATE
        src/main.cpp
)

add_subdirectory(lib/antlr4/runtime/Cpp)
target_link_libraries(flex PRIVATE antlr4_static)

include(lib/tinycc.cmake)

target_include_directories(flex PRIVATE "build/install/include")
target_link_directories(flex PRIVATE "build/install/lib")

target_link_libraries(flex PRIVATE ${TINYCC_LIBRARY})
