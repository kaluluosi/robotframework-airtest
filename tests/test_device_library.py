import os
import unittest
import tempfile
from typing import ClassVar
from robotframework_airtest.device import DeviceLibrary

APP_PACKAGE = "com.NetEase"
APP_PATH = "tests\demo\com.netease.poco.u3d.tutorial.apk"
EXE_PATH = "tests\demo\com.netease.poco.u3d.tutorial.exe"


class DeviceLibraryConnectTest(unittest.TestCase):
    def test_connect_android_default(self):
        dev_lib = DeviceLibrary(device_uri="android:///")

        self.assertFalse(dev_lib.is_connected())

        dev_lib.connect_device()

        self.assertTrue(dev_lib.is_connected())

        dev_lib.disconnect_device()

    def test_connect_windows_default(self):
        dev_lib = DeviceLibrary(
            device_uri="windows:///?title_re=com",
            pkg_name="tests\demo\com.netease.poco.u3d.tutorial.exe",
            auto_start_app=True,
        )
        dev_lib.connect_device()
        dev_lib.disconnect_device()


class AndroidDeviceTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.dev_lib = DeviceLibrary(device_uri="android:///")
        cls.dev_lib.connect_device()

    @classmethod
    def tearDownClass(cls) -> None:
        cls.dev_lib.disconnect_device()

    def test_snapshot(self):
        data = self.dev_lib.snapshot()
        self.assertIsNotNone(data)

        with tempfile.TemporaryDirectory() as dir:
            file = os.path.join(dir, "temp.png")
            self.dev_lib.snapshot(filename=file)
            self.assertTrue(os.path.exists(file))

    def test_touch(self):
        self.dev_lib.touch((100, 100))

    def test_double_click(self):
        self.dev_lib.double_click((100, 100))

    def test_swipe(self):
        self.dev_lib.swipe((100, 100), (-500, 100))

    def test_text(self):
        self.dev_lib.text("hello")

    def test_keyevent(self):
        self.dev_lib.keyevent("HOME")

    def test_get_current_resolution(self):
        resolution = self.dev_lib.get_current_resolution()
        self.assertTrue(resolution)

    def test_get_render_resolution(self):
        resolution = self.dev_lib.get_render_resolution()
        self.assertTrue(resolution)

    def test_get_ip_address(self):
        ip = self.dev_lib.get_ip_address()
        self.assertTrue(ip)

    def test_shell(self):
        echo = self.dev_lib.shell("echo hello")
        self.assertEqual(echo.strip(), "hello")


class TestAppManage(unittest.TestCase):
    dev_lib: ClassVar[DeviceLibrary]

    @classmethod
    def setUpClass(cls):
        cls.dev_lib = DeviceLibrary(device_uri="android:///")
        cls.dev_lib.connect_device()
        cls.dev_lib.install_app("tests/demo/com.netease.poco.u3d.tutorial.apk")

    @classmethod
    def tearDownClass(cls):
        if cls.dev_lib:
            cls.dev_lib.uninstall_app(APP_PACKAGE)

    def test_start_app(self):
        self.dev_lib.start_app(APP_PACKAGE)
        self.dev_lib.stop_app(APP_PACKAGE)

    def test_clear_app(self):
        self.dev_lib.clear_app(APP_PACKAGE)
