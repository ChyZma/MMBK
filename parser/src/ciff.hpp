#ifndef CIFF_H
#define CIFF_H
#include "common.hpp"

#include <sstream>

struct CIFF_SIZES {
  static const int magic = 4;
  static const int header_size = 8;
  static const int content_size = 8;
  static const int width = 8;
  static const int height = 8;
};

struct CIFF_OFFSETS {
  static const int magic = 0;
  static const int header_size = CIFF_OFFSETS::magic + CIFF_SIZES::magic;
  static const int content_size =
      CIFF_OFFSETS::header_size + CIFF_SIZES::header_size;
  static const int width =
      CIFF_OFFSETS::content_size + CIFF_SIZES::content_size;
  static const int height = CIFF_OFFSETS::width + CIFF_SIZES::width;
  static const int caption = CIFF_OFFSETS::height + CIFF_SIZES::height;
};

struct Image {
  std::vector<u16> r;
  std::vector<u16> g;
  std::vector<u16> b;
  std::vector<u16> a;

  std::vector<uint8_t> flatten();
};

class Ciff {
private:
  u64 length = -1;
  std::vector<byte> bytes;

public:
  Ciff(u64 len, u64 duration, std::vector<byte> bytes);

  u64 duration = -1;
  u64 width = 0;
  u64 height = 0;
  std::string caption = "";
  std::string s_tags = "";
  std::vector<std::string> tags;
  u16 parse();
  Image image;
};

#endif /* CIFF_H */
