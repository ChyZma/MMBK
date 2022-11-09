#include "common_tests.hpp"

// https://stackoverflow.com/a/5585683
std::vector<byte> intToBytes(u64 paramInt, std::size_t size) {
  std::vector<byte> arrayOfByte(size);
  for (u64 i = 0; i < size; i++)
    arrayOfByte[size - 1 - i] = (paramInt >> (i * 8));
  return arrayOfByte;
}
