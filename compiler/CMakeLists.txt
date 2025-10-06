add_executable(flex-c)

execute_process(
        COMMAND uvx --from antlr4-tools antlr4 -Dlanguage=Cpp -visitor -no-listener *.g4
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/src/grammar
)

file(GLOB_RECURSE SOURCES src/*.cpp src/**/*.cpp)
target_sources(flex-c PRIVATE ${SOURCES})
if (WIN32)
    target_compile_definitions(flex-c PRIVATE WIN32)
elseif (UNIX)
    target_compile_definitions(flex-c PRIVATE UNIX)
endif ()

include(FetchContent)
FetchContent_Declare(
        antlr4
        GIT_REPOSITORY https://github.com/antlr/antlr4.git
        GIT_SHALLOW TRUE
        SOURCE_SUBDIR runtime/Cpp
)
FetchContent_Declare(
        tinycc
        GIT_REPOSITORY https://repo.or.cz/tinycc.git
        GIT_SHALLOW TRUE
)
set(ANTLR_BUILD_CPP_TESTS FALSE)
set(ANTLR_BUILD_SHARED FALSE)
FetchContent_MakeAvailable(antlr4 tinycc)

set(TINYCC_INSTALL_DIR ${tinycc_SOURCE_DIR}/install)

if (NOT EXISTS ${TINYCC_INSTALL_DIR})
    if (WIN32)
        set(SHELL git-bash)
    else ()
        set(SHELL bash)
    endif ()

    execute_process(
            COMMAND ${SHELL} -c "./configure --prefix=${TINYCC_INSTALL_DIR} --enable-static && make -j4 && make install"
            WORKING_DIRECTORY ${tinycc_SOURCE_DIR}
            OUTPUT_VARIABLE output
            ERROR_VARIABLE error
            RESULT_VARIABLE result
    )
    file(
            COPY ${TINYCC_INSTALL_DIR}/lib/libtcc1.a
            DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
    )
    file(
            COPY ${TINYCC_INSTALL_DIR}/include
            DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
    )
endif ()

target_include_directories(flex-c PRIVATE ${TINYCC_INSTALL_DIR}/libtcc)
target_link_directories(flex-c PRIVATE ${TINYCC_INSTALL_DIR}/libtcc)
target_link_libraries(flex-c PRIVATE antlr4_static libtcc.a)
