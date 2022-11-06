#include "caff.hpp"

int main() {
  // TODO(mark): this should be some kind of cli tool, but this is probably fine
  // for testing
  Caff c = Caff("assets/tests/1.caff");
  c.parse();
  return 0;
}
