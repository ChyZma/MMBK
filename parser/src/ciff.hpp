#ifndef CIFF_H
#define CIFF_H
#include "common.hpp"

class Ciff {
private:
  u64 length = -1;
  u64 duration = -1;
  std::vector<byte> bytes;

public:
  Ciff(u64 len, u64 duration, std::vector<byte> bytes);
  u16 parse();
};

#endif /* CIFF_H */
