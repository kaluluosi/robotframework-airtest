import unittest
from robotframework_airtest.poco.std import parse_url_to_queryinfos


class TestStdPoco(unittest.TestCase):
    def test_parse_path_to_queryinfos(self):
        result = parse_url_to_queryinfos("btn_start")

        self.assertTrue(result)
