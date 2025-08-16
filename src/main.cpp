#include <cstdio>
#include <filesystem>
#include <iostream>
#include <libtcc.h>

int main() {
  const auto tcc = tcc_new();

  tcc_set_output_type(tcc, TCC_OUTPUT_EXE);

  tcc_compile_string(tcc, R"(
#include <stdio.h>
int main(void) {
int x = 1;
int y = 2;
  printf("%d %d\n", x, y);
  return 0;
}
)");
  const auto paths = std::filesystem::current_path();
  std::cout << paths << std::endl;
  tcc_output_file(tcc, "a.out");

  tcc_delete(tcc);

  return 0;
}