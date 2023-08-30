#include <iostream>

// Uncommenting this will make bazel rebuild the binary if hello.h changes.
// #include "hello.h"

int main() {
  std::cout << "Hello world!" << std::endl;
  return 0;
}
