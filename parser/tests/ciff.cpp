#include "caff.hpp"
#include "common_tests.hpp"
#include <boost/test/unit_test.hpp>
#include <boost/test/unit_test_suite.hpp>

BOOST_AUTO_TEST_SUITE(CIFF_tests)
BOOST_AUTO_TEST_CASE(ciff_magic_wrong) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes[CAFF_SIZES::total * 3 + CAFF_HEADER_SIZES::total + 12 +
          CAFF_CREDITS_SIZES::total + CAFF_ANIMATION_SIZES::duration] =
      (byte)'A';
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 41);
}

BOOST_AUTO_TEST_CASE(ciff_content_size_wrong) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes.erase(c.bytes.begin() + CAFF_SIZES::total * 3 +
                    CAFF_HEADER_SIZES::total + 12 + CAFF_CREDITS_SIZES::total +
                    CAFF_ANIMATION_SIZES::duration + CIFF_OFFSETS::width,
                c.bytes.begin() + CAFF_SIZES::total * 3 +
                    CAFF_HEADER_SIZES::total + 12 + CAFF_CREDITS_SIZES::total +
                    CAFF_ANIMATION_SIZES::duration + CIFF_OFFSETS::width +
                    CIFF_SIZES::width);
  auto wrong_width = intToBytes(1800, 8);
  c.bytes.insert(c.bytes.begin() + CAFF_SIZES::total * 3 +
                     CAFF_HEADER_SIZES::total + 12 + CAFF_CREDITS_SIZES::total +
                     CAFF_ANIMATION_SIZES::duration + CIFF_OFFSETS::width,
                 wrong_width.begin(), wrong_width.end());
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 42);
}

BOOST_AUTO_TEST_SUITE_END()
