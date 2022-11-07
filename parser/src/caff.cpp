#include "caff.hpp"

Caff::Caff(std::string path) { this->path = path; }

u16 Caff::parseBlock(std::vector<byte> block) {
  switch ((u16)block[0]) {
  case 1: {
    CAFF_SIZES CAFF_SIZES;
    CAFF_HEADER_SIZES CAFF_HEADER_SIZES;

    std::string magic(block.begin() + CAFF_SIZES.total,
                      block.begin() + CAFF_SIZES.total +
                          CAFF_HEADER_SIZES.magic);
    if (magic != "CAFF") {
      return 1;
    }

    u64 header_size = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_HEADER_OFFSETS::header_size,
                          block.begin() + CAFF_HEADER_OFFSETS::header_size +
                              CAFF_HEADER_SIZES::header_size));
    if (header_size != block.size() - CAFF_SIZES::total) {
      return 2;
    }
    u64 num_anim = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_HEADER_OFFSETS::num_anim,
                          block.begin() + CAFF_HEADER_OFFSETS::num_anim +
                              CAFF_HEADER_SIZES::num_anim));
    this->num_anim = num_anim;
    break;
  }
  case 2: {
    // TODO(mark): some kind of date sanitization
    u32 year = bytesToU64(std::vector<byte>(
        block.begin() + CAFF_CREDITS_OFFSETS::year,
        block.begin() + CAFF_CREDITS_OFFSETS::year + CAFF_CREDITS_SIZES::year));
    u16 month = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_CREDITS_OFFSETS::month,
                          block.begin() + CAFF_CREDITS_OFFSETS::month +
                              CAFF_CREDITS_SIZES::month));
    u16 day = bytesToU64(std::vector<byte>(
        block.begin() + CAFF_CREDITS_OFFSETS::day,
        block.begin() + CAFF_CREDITS_OFFSETS::day + CAFF_CREDITS_SIZES::day));
    u16 hour = bytesToU64(std::vector<byte>(
        block.begin() + CAFF_CREDITS_OFFSETS::hour,
        block.begin() + CAFF_CREDITS_OFFSETS::hour + CAFF_CREDITS_SIZES::hour));
    u16 minute = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_CREDITS_OFFSETS::minute,
                          block.begin() + CAFF_CREDITS_OFFSETS::minute +
                              CAFF_CREDITS_SIZES::minute));
    u64 creator_len = bytesToU64(
        std::vector<byte>(block.begin() + CAFF_CREDITS_OFFSETS::creator_len,
                          block.begin() + CAFF_CREDITS_OFFSETS::creator_len +
                              CAFF_CREDITS_SIZES::creator_len));
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
    break;
  }
  default:
    return 1;
  }

  return 0;
}

u16 Caff::parse() {
  std::ifstream caff_file(this->path, std::ifstream::binary);
  std::vector<byte> bytes((std::istreambuf_iterator<char>(caff_file)),
                          (std::istreambuf_iterator<char>()));
  caff_file.close();

  std::vector<std::vector<byte>> blocks;
  CAFF_SIZES CAFF_SIZES;

  std::size_t cnt = 0;
  while (cnt < bytes.size()) {
    u16 id = (u16)bytes[cnt + 0];
    // TODO(mark): Handle multiple header and credits blocks... Probably with
    // returning 1. Maybe use a counter for each type of block.
    if (id < 1 || id > 3) {
      return 1;
    }

    u64 len = bytesToU64(std::vector<byte>(bytes.begin() + cnt + CAFF_SIZES.id,
                                           bytes.begin() + cnt + CAFF_SIZES.id +
                                               CAFF_SIZES.length));
    if (len < 0) {
      return 1;
    }
    blocks.push_back(std::vector<byte>(
        bytes.begin() + cnt, bytes.begin() + cnt + CAFF_SIZES.total + len));

    cnt += CAFF_SIZES.id + CAFF_SIZES.length + len;
  }

  for (auto &block : blocks) {
    u16 succ = parseBlock(block);
    if (succ != 0) {
      return 1;
    }
  }

  return 0;
}
