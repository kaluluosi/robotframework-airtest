from airtest.core.device import Device
from airtest.core.win.win import Windows
from airtest.core.api import connect_device

from .windows import WindowsConnectStrategy, windows_wrapper


class UnityConnectStrategy(WindowsConnectStrategy):
    """
    连接Unity 需要Unity保持开启的状态
    """

    def __init__(self, device_uri: str, pkg_name: str):
        self.device_uri = "Windows:///?class_name=UnityContainerWndClass"
        self.pkg_name = ""
        self.device: Device = None
        self._started_app = False

    def connect(self, auto_start_app: bool = False) -> Device:
        """无法自动打开Unity，但是可以自动运行游戏。

        Args:
            start_app (bool, optional): 自动运行游戏. Defaults to False.

        Returns:
            Device: android设备
        """

        self.device: Windows = connect_device(
            "Windows:///?class_name=UnityContainerWndClass"
        )
        game_window = self.device.app.top_window().child_window(
            title="UnityEditor.GameView"
        )
        self.device._top_window = game_window.wrapper_object()
        self.device.focus_rect = (0, 40, 0, 0)

        self.device = windows_wrapper(self.device)

        # 用快捷键启动游戏
        if auto_start_app and not self._started_app:
            self.device.keyevent("^{F12}")
            self._started_app = True

        return self.device

    def disconnect(self):
        # 用快捷键停止游戏
        if self._started_app:
            self.device.keyevent("^{F12}")
            self._started_app = False

    def is_connected(self):
        return self._started_app
