import unittest
from robotframework_airtest.poco.base import BasePocoLibrary


class TestStdPoco(unittest.TestCase):
    def test_parse_path_to_queryinfos(self):
        result = BasePocoLibrary.parse_url_to_queryinfos("btn_start")

        self.assertTrue(result)
