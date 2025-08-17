set(ANTLR4_SOURCE_DIR ${CMAKE_SOURCE_DIR}/lib/antlr4)
set(ANTLR4_JAR_PATH ${INSTALL_DIR}/org/antlr/antlr4/*/antlr4-*-complete.jar)
set(GRAMMAR_DIR ${CMAKE_SOURCE_DIR}/src/grammar)

file(GLOB ANTLR4_JAR ${ANTLR4_JAR_PATH})

if (NOT ANTLR4_JAR)
    execute_process(
            COMMAND mvn -Dmaven.repo.local=${INSTALL_DIR} install
            WORKING_DIRECTORY ${ANTLR4_SOURCE_DIR}
    )

    file(GLOB ANTLR4_JAR ${ANTLR4_JAR_PATH})

    if (NOT ANTLR4_JAR)
        message(FATAL_ERROR "Unable to build antlr4 jar")
    endif ()
endif ()

message("Found Antlr4 Jar: ${ANTLR4_JAR}")

# Find Grammar File
file(GLOB GRAMMAR_FILE "${GRAMMAR_DIR}/*.g4")
if (NOT GRAMMAR_FILE)
    message(FATAL_ERROR "Unable to find grammar file")
endif ()
message("Found grammar file: ${GRAMMAR_FILE}")

# Generate Antlr4 files
execute_process(
        COMMAND java -jar ${ANTLR4_JAR} -Dlanguage=Cpp ${GRAMMAR_FILE}
        WORKING_DIRECTORY ${GRAMMAR_DIR}
)
file(GLOB_RECURSE GRAMMAR_SOURCE_FILE "${GRAMMAR_DIR}/*.cpp")
message("Grammar source files: ${GRAMMAR_SOURCE_FILE}")