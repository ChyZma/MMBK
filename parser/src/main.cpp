#include "caff.hpp"

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
      return 1;
    }
    std::string caff_path = argv[1];
    std::string gif_dest = argv[2];
    std::string meta_dest = argv[3];

    Caff c = Caff(caff_path);
    c.parse();
    c.generateGif(gif_dest);
    c.generateMeta(meta_dest);
    return 0;
  } else {
    help();
  }

  return 0;
}
