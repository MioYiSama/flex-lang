#include <antlr4-runtime.h>
#include <libtcc.h>

#include <cstdlib>
#include <filesystem>
#include <iostream>

#include "grammar/FlexLexer.h"
#include "grammar/FlexParser.h"
#include "grammar/FlexParserBaseVisitor.h"
#include "util.hpp"

class Visitor final : public FlexParserBaseVisitor {
 public:
  std::any visitProgram(FlexParser::ProgramContext* context) override {
    std::cout << "1" << std::endl;
    return {};
  }
};

int main(int argc, char* argv[]) {
  if (argc != 2) {
    std::cerr << "Usage: flex-c <file>" << std::endl;
    return EXIT_FAILURE;
  }

  const auto file = argv[1];

  std::ifstream stream{file};
  if (!stream) {
    std::cerr << "Unable to open file: " << file << std::endl;
    return EXIT_FAILURE;
  }

  auto tcc = tcc_new();
  tcc_add_library_path(tcc, getExecutablePath().c_str());
  tcc_add_include_path(tcc, (getExecutablePath() + "include").c_str());
  tcc_set_output_type(tcc, TCC_OUTPUT_EXE);

  tcc_compile_string(tcc, R"(
#include <stdio.h>
int main(void) {
  printf("%d + %d = %d\n", 1, 2, 3);
  return 0;
}
)");
  tcc_output_file(tcc, "1.exe");
  tcc_delete(tcc);

  antlr4::ANTLRInputStream inputStream{stream};
  FlexLexer lexer{&inputStream};
  antlr4::CommonTokenStream tokenStream{&lexer};
  FlexParser parser{&tokenStream};

  auto program = parser.program();

  if (parser.getNumberOfSyntaxErrors() > 0) {
    std::cerr << "Error parsing file: " << file << std::endl;
    return EXIT_FAILURE;
  }

  Visitor visitor;
  visitor.visit(program);

  return EXIT_SUCCESS;
}
