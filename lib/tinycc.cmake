set(TINYCC_SOURCE_DIR ${CMAKE_SOURCE_DIR}/lib/tinycc)
set(TINYCC_LIBRARY libtcc.a)

if (NOT EXISTS ${INSTALL_DIR}/lib/${TINYCC_LIBRARY})
    execute_process(
            COMMAND ./configure --prefix=${INSTALL_DIR}
            COMMAND make -j12
            COMMAND make install
            WORKING_DIRECTORY ${TINYCC_SOURCE_DIR}
    )
endif ()
