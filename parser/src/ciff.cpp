#include "ciff.hpp"

Ciff::Ciff(u64 len, u64 duration, std::vector<byte> bytes) {
  this->length = len;
  this->duration = duration;
  this->bytes = bytes;
}

u16 Ciff::parse() { return 1; }
