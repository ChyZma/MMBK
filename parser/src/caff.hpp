#ifndef CAFF_H
#define CAFF_H

#include <algorithm>
#include <fstream>
#include <numeric>
#include <ostream>
#include <string>

#include "ciff.hpp"
#include "common.hpp"

struct CAFF_SIZES {
  static const int id = 1;
  static const int length = 8;
  static const int total = id + length;
};

struct CAFF_OFFSETS {
  static const int id = 0;
  static const int length = CAFF_SIZES::id;
};

struct CAFF_HEADER_SIZES {
  static const int magic = 4;
  static const int header_size = 8;
  static const int num_anim = 8;
  static const int total = magic + header_size + num_anim;
};

struct CAFF_HEADER_OFFSETS {
  static const int magic = CAFF_SIZES::total;
  static const int header_size =
      CAFF_HEADER_OFFSETS::magic + CAFF_HEADER_SIZES::magic;
  static const int num_anim =
      CAFF_HEADER_OFFSETS::header_size + CAFF_HEADER_SIZES::header_size;
};

struct CAFF_CREDITS_SIZES {
  static const int year = 2;
  static const int month = 1;
  static const int day = 1;
  static const int hour = 1;
  static const int minute = 1;
  static const int creator_len = 8;
  static const int total = year + month + day + hour + minute + creator_len;
};

struct CAFF_CREDITS_OFFSETS {
  static const int year = CAFF_SIZES::total;
  static const int month =
      CAFF_CREDITS_OFFSETS::year + CAFF_CREDITS_SIZES::year;
  static const int day =
      CAFF_CREDITS_OFFSETS::month + CAFF_CREDITS_SIZES::month;
  static const int hour = CAFF_CREDITS_OFFSETS::day + CAFF_CREDITS_SIZES::day;
  static const int minute =
      CAFF_CREDITS_OFFSETS::hour + CAFF_CREDITS_SIZES::hour;
  static const int creator_len =
      CAFF_CREDITS_OFFSETS::minute + CAFF_CREDITS_SIZES::minute;
  static const int creator =
      CAFF_CREDITS_OFFSETS::creator_len + CAFF_CREDITS_SIZES::creator_len;
};

struct CAFF_ANIMATION_SIZES {
  static const int duration = 8;
};

struct CAFF_ANIMATION_OFFSETS {
  static const int duration = CAFF_SIZES::total;
  static const int ciff =
      CAFF_ANIMATION_OFFSETS::duration + CAFF_ANIMATION_SIZES::duration;
};

struct CaffCredits {
  u32 year = -1;
  u16 month = -1;
  u16 day = -1;
  u16 hour = -1;
  u16 minute = -1;
  u64 creator_len = -1;
  std::string creator = "";
};

class Caff {
private:
  std::string path;
  u64 num_anim = -1;
  CaffCredits credits;
  std::vector<Ciff> ciffs;

public:
  Caff(std::string path);
  u16 loadFile();
  std::vector<byte> bytes;
  u16 parseBlock(std::vector<byte> block);
  u16 parse();
  u16 generateGif(std::string path);
  u16 generateMeta(std::string path);
};

#endif /* CAFF_H */
