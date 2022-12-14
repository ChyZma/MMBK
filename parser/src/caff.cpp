#include "caff.hpp"
#include "gif.h"
#include <ostream>
#include <vector>

Caff::Caff(std::string path) { this->path = path; }
u16 Caff::loadFile() {
  std::ifstream caff_file(this->path, std::ifstream::binary);
  if (!caff_file.is_open()) {
    return 12;
  }
  this->bytes = std::vector<byte>((std::istreambuf_iterator<char>(caff_file)),
                                  (std::istreambuf_iterator<char>()));
  caff_file.close();
  return 0;
}

u16 Caff::parseBlock(std::vector<byte> block) {
  switch ((u16)block[0]) {
  case 1: {
    std::string magic(block.begin() + CAFF_HEADER_OFFSETS::magic,
                      block.begin() + CAFF_HEADER_OFFSETS::magic +
                          CAFF_HEADER_SIZES::magic);
    if (magic != "CAFF") {
      return 24;
    }

    u64 header_size = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_HEADER_OFFSETS::header_size,
                          block.begin() + CAFF_HEADER_OFFSETS::header_size +
                              CAFF_HEADER_SIZES::header_size));
    if (header_size != block.size() - CAFF_SIZES::total) {
      return 25;
    }
    u64 num_anim = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_HEADER_OFFSETS::num_anim,
                          block.begin() + CAFF_HEADER_OFFSETS::num_anim +
                              CAFF_HEADER_SIZES::num_anim));
    this->num_anim = num_anim;
    break;
  }
  case 2: {
    u32 year = bytesToU64(std::vector<byte>(
        block.begin() + CAFF_CREDITS_OFFSETS::year,
        block.begin() + CAFF_CREDITS_OFFSETS::year + CAFF_CREDITS_SIZES::year));
    if (year < 1900 || year > 2030) {
      return 26;
    }

    u16 month = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_CREDITS_OFFSETS::month,
                          block.begin() + CAFF_CREDITS_OFFSETS::month +
                              CAFF_CREDITS_SIZES::month));
    if (month < 1 || month > 12) {
      return 26;
    }

    u16 day = bytesToU64(std::vector<byte>(
        block.begin() + CAFF_CREDITS_OFFSETS::day,
        block.begin() + CAFF_CREDITS_OFFSETS::day + CAFF_CREDITS_SIZES::day));
    if (day < 1 || day > 31) {
      return 26;
    }

    u16 hour = bytesToU64(std::vector<byte>(
        block.begin() + CAFF_CREDITS_OFFSETS::hour,
        block.begin() + CAFF_CREDITS_OFFSETS::hour + CAFF_CREDITS_SIZES::hour));
    if (hour < 0 || hour > 24) {
      return 26;
    }

    u16 minute = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_CREDITS_OFFSETS::minute,
                          block.begin() + CAFF_CREDITS_OFFSETS::minute +
                              CAFF_CREDITS_SIZES::minute));
    if (minute < 0 || minute > 60) {
      return 26;
    }

    u64 creator_len = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_CREDITS_OFFSETS::creator_len,
                          block.begin() + CAFF_CREDITS_OFFSETS::creator_len +
                              CAFF_CREDITS_SIZES::creator_len));
    if (creator_len < 1) {
      return 27;
    }

    std::string creator(block.begin() + CAFF_CREDITS_OFFSETS::creator,
                        block.begin() + CAFF_CREDITS_OFFSETS::creator +
                            creator_len);
    this->credits = {year, month, day, hour, minute, creator_len, creator};
    break;
  }
  case 3: {
    u64 len = bytesToU64(std::vector<byte>(
        block.begin() + CAFF_OFFSETS::length,
        block.begin() + CAFF_OFFSETS::length + CAFF_SIZES::length));

    u64 duration = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_ANIMATION_OFFSETS::duration,
                          block.begin() + CAFF_ANIMATION_OFFSETS::duration +
                              CAFF_ANIMATION_SIZES::duration));
    Ciff ciff = Ciff(
        len, duration,
        std::vector<byte>(block.begin() + CAFF_ANIMATION_OFFSETS::ciff,
                          block.begin() + CAFF_ANIMATION_OFFSETS::ciff + len));
    this->ciffs.push_back(ciff);
    break;
  }
  default:
    return 28;
  }

  return 0;
}

u16 Caff::parse() {
  std::vector<std::vector<byte>> blocks;

  std::size_t cnt = 0;
  bool header_found = false;
  bool credits_found = false;
  while (cnt < bytes.size()) {
    u16 id = (u16)bytes[cnt + 0];
    switch (id) {
    case 1: {
      if (header_found == true) {
        return 21;
      }
      header_found = true;
      break;
    }
    case 2:
      if (credits_found == true) {
        return 22;
      }
      credits_found = true;
      break;

    default:
      break;
    }
    if (id < 1 || id > 3) {
      return 28;
    }

    u64 len = bytesToU64(std::vector<byte>(
        bytes.begin() + cnt + CAFF_OFFSETS::length,
        bytes.begin() + cnt + CAFF_OFFSETS::length + CAFF_SIZES::length));
    if (len < 0) {
      return 29;
    }
    blocks.push_back(std::vector<byte>(
        bytes.begin() + cnt, bytes.begin() + cnt + CAFF_SIZES::total + len));

    cnt += CAFF_SIZES::total + len;
  }

  if (header_found == false || credits_found == false) {
    return 23;
  }

  for (auto &block : blocks) {
    u16 succ = parseBlock(block);
    if (succ != 0) {
      return succ;
    }
  }
  for (auto &ciff : ciffs) {
    u16 succ = ciff.parse();
    if (succ != 0) {
      return succ;
    }
  }

  return 0;
}

u16 Caff::generateGif(std::string path) {
  GifWriter g;
  u32 max_width = 0;
  u32 max_height = 0;
  for (auto &ciff : this->ciffs) {
    if ((u32)ciff.width > max_width) {
      max_width = (u32)ciff.width;
    }
    if ((u32)ciff.height > max_height) {
      max_height = (u32)ciff.height;
    }
  }

  GifBegin(&g, path.c_str(), max_width, max_height,
           this->ciffs[0].duration / 10, 8, true);

  for (auto &ciff : this->ciffs) {
    if (GifWriteFrame(&g, ciff.image.flatten().data(), ciff.width, ciff.height,
                      ciff.duration / 10) != 1) {
      return 31;
    }
  }

  GifEnd(&g);
  return 0;
}

u16 Caff::generateMeta(std::string path) {
  std::ofstream out_file(path);
  if (out_file.is_open()) {
    out_file << "[caff]" << std::endl;
    out_file << "number_of_animations = " << this->num_anim << std::endl;
    out_file << "creation_time = " << this->credits.year << "-"
             << this->credits.month << "-" << this->credits.day << "T"
             << this->credits.hour << ":" << this->credits.minute << std::endl;
    out_file << "creator = " << this->credits.creator << std::endl;
    for (u64 i = 0; i < this->ciffs.size(); i++) {
      auto ciff = this->ciffs[i];
      out_file << "[ciff_" << i << "]" << std::endl;
      out_file << "width = " << ciff.width << std::endl;
      out_file << "height = " << ciff.height << std::endl;
      out_file << "duration = " << ciff.duration << std::endl;
      out_file << "caption = " << ciff.caption << std::endl;
      std::string conneceted_tags = std::accumulate(
          std::next(ciff.tags.begin()), ciff.tags.end(), ciff.tags[0],
          [](std::string a, std::string b) { return a + ',' + b; });
      out_file << "tags = " << conneceted_tags << std::endl;
    }
    out_file.close();
  } else {
    return 32;
  }
  return 0;
}

extern "C" Caff *Caff_Create(const char *path) {
  return new Caff(std::string(path));
}
extern "C" u16 Caff_Loadfile(Caff *c) { return c->loadFile(); }
extern "C" u16 Caff_Parse(Caff *c) { return c->parse(); }
extern "C" u16 __Caff_GenerateGif__(Caff *c, const char *path) {
  return c->generateGif(std::string(path));
}

extern "C" u32 Caff_GetCreditsYear(Caff *c) { return c->credits.year; }
extern "C" u16 Caff_GetCreditsMonth(Caff *c) { return c->credits.month; }
extern "C" u16 Caff_GetCreditsDay(Caff *c) { return c->credits.day; }
extern "C" u16 Caff_GetCreditsHour(Caff *c) { return c->credits.hour; }
extern "C" u16 Caff_GetCreditsMinute(Caff *c) { return c->credits.minute; }
extern "C" void __Caff_GetCreditsCreator__(Caff *c, char *str) {
  std::string creator = c->credits.creator.c_str();

  creator = creator.substr(0, c->credits.creator_len + 1);

  std::copy(creator.begin(), creator.end(), str);

  str[std::min((int)c->credits.creator_len, (int)creator.size())] = 0;
}

extern "C" void __Caff_GetCaption__(Caff *c, char *str) {
  std::string caption = c->ciffs[0].caption.c_str();
  int len = c->ciffs[0].caption.length();

  caption = caption.substr(0, len + 1);

  std::copy(caption.begin(), caption.end(), str);

  str[std::min(len, (int)caption.size())] = 0;
}

extern "C" void __Caff_GetTagsString__(Caff *c, char *str) {
  std::string tags_string = c->ciffs[0].s_tags.c_str();
  int len = c->ciffs[0].s_tags.length();

  tags_string = tags_string.substr(0, len + 1);

  std::copy(tags_string.begin(), tags_string.end(), str);

  str[std::min(len, (int)tags_string.size())] = 0;
}
