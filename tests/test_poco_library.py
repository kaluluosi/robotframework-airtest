import unittest
from robotframework_airtest.poco.std import parse_url_to_queryinfos


class TestStdPoco(unittest.TestCase):
    def test_parse_path_to_queryinfos(self):
        result = parse_url_to_queryinfos("btn_start")

        self.assertTrue(result)

    def test_guest(self):
        from poco.drivers.unity3d import UnityPoco
        from airtest.core.api import connect_device

        connect_device("android:///")

        poco = UnityPoco()

        star = poco("star")
        shell = poco("shell")

        star_pos = star.get_position()
        shell_pos = shell.get_position()

        poco.device.keyevent(star_pos[0], star_pos[1])
        poco.device.key_press("LEFT")

        poco.device.mouse_down(shell_pos[0], shell_pos[1])
        poco.device.key_release("LEFT")

        poco.start_gesture
