#include "caff.hpp"
#include "common_tests.hpp"
#include <boost/test/unit_test.hpp>
#include <boost/test/unit_test_suite.hpp>
#include <vector>
using namespace std;

BOOST_AUTO_TEST_SUITE(CAFF_tests)
BOOST_AUTO_TEST_CASE(caff_test_file_load_success) {
  Caff c = Caff("../assets/tests/1.caff");
  u16 ret = c.loadFile();
  BOOST_REQUIRE(ret == 0);
}
BOOST_AUTO_TEST_CASE(caff_test_file_load_failed) {
  Caff c = Caff("../assets/tests/1337.caff");
  u16 ret = c.loadFile();
  BOOST_REQUIRE(ret == 12);
}
BOOST_AUTO_TEST_CASE(caff_parse_success) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 0);
}
BOOST_AUTO_TEST_CASE(caff_test_wrong_id_smaller) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes[0] = (byte)0;
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 28);
}
BOOST_AUTO_TEST_CASE(caff_test_wrong_id_larger) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes[0] = (byte)4;
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 28);
}

BOOST_AUTO_TEST_CASE(caff_test_multiple_headers) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes[CAFF_HEADER_OFFSETS::num_anim + CAFF_HEADER_SIZES::num_anim] =
      (byte)1;
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 21);
}

BOOST_AUTO_TEST_CASE(caff_test_multiple_credits) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes[0] = (byte)2;
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 22);
}

BOOST_AUTO_TEST_CASE(caff_test_no_header_or_credits) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes[CAFF_HEADER_OFFSETS::num_anim + CAFF_HEADER_SIZES::num_anim] =
      (byte)3;
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 23);
}

BOOST_AUTO_TEST_CASE(caff_test_wrong_header_size) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes.erase(c.bytes.begin() + CAFF_HEADER_OFFSETS::header_size,
                c.bytes.begin() + CAFF_HEADER_OFFSETS::header_size +
                    CAFF_HEADER_SIZES::header_size);
  auto wrong_size = intToBytes(42, 8);
  c.bytes.insert(c.bytes.begin() + CAFF_HEADER_OFFSETS::header_size,
                 wrong_size.begin(), wrong_size.end());
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 25);
}

BOOST_AUTO_TEST_CASE(caff_test_date_wrong_year) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes.erase(c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::year,
                c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::year + CAFF_CREDITS_SIZES::year);
  auto wrong_year = intToBytes(1800, 2);
  c.bytes.insert(c.bytes.begin() + CAFF_SIZES::total +
                     CAFF_HEADER_SIZES::total + CAFF_CREDITS_OFFSETS::year,
                 wrong_year.begin(), wrong_year.end());
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 26);
}

BOOST_AUTO_TEST_CASE(caff_test_date_wrong_month) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes.erase(c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::month,
                c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::month + CAFF_CREDITS_SIZES::month);
  auto wrong_month = intToBytes(13, 1);
  c.bytes.insert(c.bytes.begin() + CAFF_SIZES::total +
                     CAFF_HEADER_SIZES::total + CAFF_CREDITS_OFFSETS::month,
                 wrong_month.begin(), wrong_month.end());
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 26);
}

BOOST_AUTO_TEST_CASE(caff_test_date_wrong_day) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes.erase(c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::day,
                c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::day + CAFF_CREDITS_SIZES::day);
  auto wrong_day = intToBytes(32, 1);
  c.bytes.insert(c.bytes.begin() + CAFF_SIZES::total +
                     CAFF_HEADER_SIZES::total + CAFF_CREDITS_OFFSETS::day,
                 wrong_day.begin(), wrong_day.end());
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 26);
}

BOOST_AUTO_TEST_CASE(caff_test_date_wrong_hour) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes.erase(c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::hour,
                c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::hour + CAFF_CREDITS_SIZES::hour);
  auto wrong_hour = intToBytes(25, 1);
  c.bytes.insert(c.bytes.begin() + CAFF_SIZES::total +
                     CAFF_HEADER_SIZES::total + CAFF_CREDITS_OFFSETS::hour,
                 wrong_hour.begin(), wrong_hour.end());
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 26);
}

BOOST_AUTO_TEST_CASE(caff_test_date_wrong_minute) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes.erase(c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::minute,
                c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::minute + CAFF_CREDITS_SIZES::minute);
  auto wrong_minute = intToBytes(61, 1);
  c.bytes.insert(c.bytes.begin() + CAFF_SIZES::total +
                     CAFF_HEADER_SIZES::total + CAFF_CREDITS_OFFSETS::minute,
                 wrong_minute.begin(), wrong_minute.end());
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 26);
}

BOOST_AUTO_TEST_CASE(caff_test_wrong_creator_len) {
  Caff c = Caff("../assets/tests/1.caff");
  c.loadFile();
  c.bytes.erase(c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::creator_len,
                c.bytes.begin() + CAFF_SIZES::total + CAFF_HEADER_SIZES::total +
                    CAFF_CREDITS_OFFSETS::creator_len +
                    CAFF_CREDITS_SIZES::creator_len);
  auto wrong_creator_len = intToBytes(0, 8);
  c.bytes.insert(c.bytes.begin() + CAFF_SIZES::total +
                     CAFF_HEADER_SIZES::total +
                     CAFF_CREDITS_OFFSETS::creator_len,
                 wrong_creator_len.begin(), wrong_creator_len.end());
  u16 ret = c.parse();
  BOOST_REQUIRE(ret == 27);
}

BOOST_AUTO_TEST_CASE(caff_test3) { BOOST_REQUIRE((2 + 2) == 4); }
BOOST_AUTO_TEST_CASE(caff_test4) { BOOST_REQUIRE((2 + 2) == 4); }
BOOST_AUTO_TEST_CASE(caff_test5) { BOOST_REQUIRE((2 + 2) == 4); }
BOOST_AUTO_TEST_CASE(caff_test6) { BOOST_REQUIRE((2 + 2) == 4); }
BOOST_AUTO_TEST_SUITE_END()
