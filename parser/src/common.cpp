#include "common.hpp"

u64 bytesToU64(std::vector<byte> bytes) {
  if (bytes.size() > 8) {
    return -1;
  }

  if (bytes.size() < 8) {
    bytes.resize(bytes.size() + 8 - bytes.size(), 0);
  }
  return ((u64)bytes[7] << 56) | ((u64)bytes[6] << 48) | ((u64)bytes[5] << 40) |
         ((u64)bytes[4] << 32) | (u64)(bytes[3] << 24) | (u64)(bytes[2] << 16) |
         (u64)(bytes[1] << 8) | (u64)bytes[0];
}
