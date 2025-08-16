set(TINYCC_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/tinycc)
set(TINYCC_LIBRARY libtcc.a)

execute_process(
        COMMAND ./configure --prefix=${CMAKE_SOURCE_DIR}/build/install
        WORKING_DIRECTORY ${TINYCC_SOURCE_DIR}
)
execute_process(
        COMMAND make -j12
        WORKING_DIRECTORY ${TINYCC_SOURCE_DIR}
)
execute_process(
        COMMAND make install
        WORKING_DIRECTORY ${TINYCC_SOURCE_DIR}
)
