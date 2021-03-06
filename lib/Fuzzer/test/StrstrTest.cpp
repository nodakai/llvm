// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.

// Test strstr and strcasestr hooks.
#include <string>
#include <string.h>
#include <cstdint>
#include <cstdio>
#include <cstdlib>

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
  if (Size < 4) return 0;
  std::string s(reinterpret_cast<const char*>(Data), Size);
  if (strstr(s.c_str(), "FUZZ") &&
      strcasestr(s.c_str(), "aBcD") &&
      memmem(s.data(), s.size(), "kuku", 4)
      ) {
    fprintf(stderr, "BINGO\n");
    exit(1);
  }
  return 0;
}
