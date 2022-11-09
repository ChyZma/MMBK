#include "caff.hpp"
#include <iostream>

void help() {
  std::cout << "Usage: mmbk SOURCE GIF_DEST META_DEST" << std::endl;
}

int main(int argc, char *argv[]) {
  if (argc > 0) {
    if ((std::string)argv[1] == "help") {
      help();
      return 0;
    }
    if (argc < 3) {
      help();
      std::cerr << "CAFF Path, gif destination and meta destination are "
                   "required arguments"
                << std::endl;
      return 11;
    }
    std::string caff_path = argv[1];
    std::string gif_dest = argv[2];
    std::string meta_dest = argv[3];

    Caff c = Caff(caff_path);
    u16 caff_load_file = c.loadFile();
    if (caff_load_file != 0) {
      return caff_load_file;
    }

    u16 caff_parse = c.parse();
    if (caff_parse != 0) {
      return caff_parse;
    }
    u16 gif_gen = c.generateGif(gif_dest);
    if (gif_gen != 0) {
      return gif_gen;
    }
    u16 meta_gen = c.generateMeta(meta_dest);
    if (meta_gen != 0) {
      return meta_gen;
    }

  } else {
    help();
  }

  return 0;
}
