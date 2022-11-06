#include <boost/test/unit_test.hpp>
#include <boost/test/unit_test_suite.hpp>
#define BOOST_TEST_LOG_LEVEL all

BOOST_AUTO_TEST_SUITE(CAFF_tests)
BOOST_AUTO_TEST_CASE(caff_test1) { BOOST_REQUIRE((2 + 2) == 4); }
BOOST_AUTO_TEST_CASE(caff_test2) { BOOST_REQUIRE((2 + 2) == 4); }
BOOST_AUTO_TEST_CASE(caff_test3) { BOOST_REQUIRE((2 + 2) == 4); }
BOOST_AUTO_TEST_SUITE_END()
