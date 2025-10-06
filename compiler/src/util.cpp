#include "util.hpp"

#include <filesystem>

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

std::string getExecutablePath() {
#ifdef WIN32
  char buffer[MAX_PATH];
  GetModuleFileName(nullptr, buffer, MAX_PATH);

  const std::filesystem::path p{buffer};

  return p.parent_path().string();
#elifdef UNIX
#error "TODO"
#else
#error "Unsupported OS"
#endif
}