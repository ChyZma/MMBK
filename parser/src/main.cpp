#include "caff.hpp"

int main() {
  // TODO(mark): this should be some kind of cli tool, but this is probably fine
  // for testing
  Caff c = Caff("assets/tests/2.caff", "test");
  c.parse();
  c.generateGif("test.gif");
  c.generateMeta("test.ini");
  return 0;
}
