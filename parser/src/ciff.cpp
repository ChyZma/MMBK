#include "ciff.hpp"

std::vector<uint8_t> Image::flatten() {
  std::vector<uint8_t> ret;
  for (u64 i = 0; i < this->r.size(); i++) {
    ret.push_back(this->r[i]);
    ret.push_back(this->g[i]);
    ret.push_back(this->b[i]);
    ret.push_back(this->a[i]);
  }

  return ret;
}

Ciff::Ciff(u64 len, u64 duration, std::vector<byte> bytes) {
  this->length = len;
  this->duration = duration;
  this->bytes = bytes;
}

u16 Ciff::parse() {
  std::string magic(bytes.begin() + CIFF_OFFSETS::magic,
                    bytes.begin() + CIFF_OFFSETS::magic + CIFF_SIZES::magic);
  if (magic != "CIFF") {
    return 41;
  }
  u64 header_size = bytesToU64(std::vector<byte>(
      bytes.begin() + CIFF_OFFSETS::header_size,
      bytes.begin() + CIFF_OFFSETS::header_size + CIFF_SIZES::header_size));

  u64 content_size = bytesToU64(std::vector<byte>(
      bytes.begin() + CIFF_OFFSETS::content_size,
      bytes.begin() + CIFF_OFFSETS::content_size + CIFF_SIZES::content_size));

  this->height = bytesToU64(std::vector<byte>(
      bytes.begin() + CIFF_OFFSETS::height,
      bytes.begin() + CIFF_OFFSETS::height + CIFF_SIZES::height));

  this->width = bytesToU64(std::vector<byte>(
      bytes.begin() + CIFF_OFFSETS::width,
      bytes.begin() + CIFF_OFFSETS::width + CIFF_SIZES::width));

  if (this->height * this->width * 3 != content_size) {
    return 42;
  }

  std::string caption_and_tags_string = std::string(
      bytes.begin() + CIFF_OFFSETS::caption, bytes.begin() + header_size);

  std::size_t caption_end = caption_and_tags_string.find('\n');
  this->caption = caption_and_tags_string.substr(0, caption_end);

  std::string tags_string = caption_and_tags_string.substr(
      caption_end + 1, caption_and_tags_string.size());
  std::stringstream tags_stream(tags_string);
  std::string segment;
  while (std::getline(tags_stream, segment, '\0')) {
    this->tags.push_back(segment);
    this->s_tags += segment + ",";
  }
  s_tags[s_tags.length() - 1] = '\0';

  u64 content_offset = header_size;
  std::vector<byte> content(bytes.begin() + content_offset,
                            bytes.begin() + content_offset + content_size);
  for (u64 i = 0; i < content_size; i += 3) {
    this->image.r.push_back((u16)content[i]);
    this->image.g.push_back((u16)content[i + 1]);
    this->image.b.push_back((u16)content[i + 2]);
    this->image.a.push_back(255);
  }

  return 0;
}
