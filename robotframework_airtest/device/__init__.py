from typing import Tuple
from airtest.core.settings import Settings
from robot.api import logger, deco
from robot.libraries.BuiltIn import BuiltIn
from .connects import ConnectStrategyBase, factory

# 坐标点类型声明
Point = Tuple[float, float]


class DeviceLibrary:
    ROBOT_LIBRARY_SCOPE = "GLOBAL"
    ROBOT_LIBRARY_FORMAT = "rsST"

    def __init__(
        self, device_uri: str = "", pkg_name: str = None, auto_start_app: bool = False
    ):
        """初始化库是传入的参数将会作为连接设备关键字的默认参数用

        Args:
            device_uri (str, optional): 默认设备uri. Defaults to "".
            pkg_name (str, optional): 默认包名. Defaults to None.
            auto_start_app (bool, optional): 默认自动打开app开关. Defaults to False.
        """
        # ${AUTO_START_APP} 是个True/False字符串，得判断转换成bool
        self.auto_start_app = auto_start_app or self.var("${auto_start_app}") == "True"
        self.device_uri = device_uri or self.var("${device_uri}")
        self.pkg_name = pkg_name or self.var("${pkg_name}")
        self.conn: ConnectStrategyBase = None
        logger.console(
            "DeviceLibrary初始化 device_uri:{} pkg_name:{} auto_start_app:{}".format(
                self.device_uri,
                self.pkg_name,
                self.auto_start_app,
            )
        )

    def var(self, name):
        try:
            return BuiltIn().get_variable_value(name, default="")
        except Exception:
            return ""

    # region 关键字定义

    @deco.keyword("连接设备")
    def connect_device(
        self,
        _device_uri: str = "",
        _pkg_name: str = None,
        _auto_start_app: bool = False,
    ):
        """如果传入了 _device_uri参数那么就会在这一次连接设备覆盖掉DeviceLibrary初始化时的默认参数。

        Args:
            _device_uri (str, optional): [description]. Defaults to "".
            _pkg_name (str, optional): [description]. Defaults to None.
            _auto_start_app (bool, optional): [description]. Defaults to False.
        """
        device_uri = _device_uri if _device_uri else self.device_uri
        pkg_name = _pkg_name if _pkg_name else self.pkg_name
        auto_start_app = _auto_start_app if _auto_start_app else self.auto_start_app

        logger.console(
            "连接设备： device_uri={} pkg_name={} auto_start_app={}".format(
                device_uri, pkg_name, auto_start_app
            )
        )
        self.conn = factory(device_uri, pkg_name)
        self.conn.connect(auto_start_app)
        logger.console("连接设备成功")
        if getattr(Settings, "RECORDING", None):
            self.start_recording()

    @deco.keyword("断开设备")
    def disconnect_device(self):
        if getattr(Settings, "RECORDING", None):
            self.stop_recording()
        self.conn.disconnect() if self.conn else logger.console("设备并没有连接")

    @deco.keyword("开始录像")
    def start_recording(self, output: str = None, *args, **kwargs):
        save_path = self.conn.device.start_recording(output=output, *args, **kwargs)
        logger.console("设备开始录像")
        return save_path

    @deco.keyword("结束录像")
    def stop_recording(self, output: str = None, *args, **kwargs):
        """结束录像

        args和kwargs可以传递具体Device的start_recording的参数过去。

        Args:
            output (str, optional): 另存为，默认会保存到当前目录，视频格式是mp4. Defaults to None.
        """
        self.conn.device.stop_recording(output=output, *args, **kwargs)

    @deco.keyword("连接中")
    def is_connected(self):
        return self.conn and self.conn.is_connected

    @deco.keyword("未连接")
    def is_disconnected(self):
        return not self.conn.is_connected

    @deco.keyword("截图")
    def snapshot(self, filename: str = None, *args, **kwargs) -> bytes:
        data = self.conn.device.snapshot(filename=filename, *args, **kwargs)
        return data

    @deco.keyword("点击")
    def touch(self, pos: Point, **kwargs):
        self.conn.device.touch(pos, **kwargs)

    @deco.keyword("双击")
    def double_click(self, pos: Point):
        self.conn.device.double_click(pos)

    @deco.keyword("滑动")
    def swipe(self, t1: Point, t2: Point, **kwargs):
        self.conn.device.swipe(t1, t2, **kwargs)

    @deco.keyword("模拟按键事件")
    def keyevent(self, key: str, **kwargs):
        """
        keycode文档
        https://pywinauto.readthedocs.io/en/latest/code/pywinauto.keyboard.html

        Args:
            key (str): keycode 按键码
        """
        self.conn.device.keyevent(key, **kwargs)

    @deco.keyword("输入文本")
    def text(self, text: str):
        self.conn.device.text(text)

    @deco.keyword("启动APP")
    def start_app(self, package: str, **kwargs):
        self.conn.device.start_app(package, **kwargs)

    @deco.keyword("停止APP")
    def stop_app(self, package: str):
        self.conn.device.stop_app(package)

    @deco.keyword("清理APP缓存")
    def clear_app(self, package: str):
        self.conn.device.clear_app(package)

    @deco.keyword("列出安装的APP")
    def list_app(self, **kwargs):
        return self.conn.device.list_app(**kwargs)

    @deco.keyword("是否已安装APP")
    def is_app_installed(self, package: str, **kwargs):
        app_list = self.list_app(**kwargs)
        return package in app_list

    @deco.keyword("APP必须安装成功")
    def should_install_app(self, package: str, **kwargs):
        if not self.is_app_installed(package):
            BuiltIn().fail(msg=f"{package}没有安装")

    @deco.keyword("安装APP")
    def install_app(self, uri: str, **kwargs):
        self.conn.device.install_app(uri, **kwargs)

    @deco.keyword("卸载APP")
    def uninstall_app(self, package: str):
        self.conn.device.uninstall_app(package)

    @deco.keyword("获取分辨率")
    def get_current_resolution(self):
        return self.conn.device.get_current_resolution()

    @deco.keyword("获取渲染分辨率")
    def get_render_resolution(self):
        return self.conn.device.get_render_resolution()

    @deco.keyword("获取IP")
    def get_ip_address(self):
        return self.conn.device.get_ip_address()

    @deco.keyword("shell命令")
    def shell(self, *args, **kwargs) -> str:
        return self.conn.device.shell(*args, **kwargs)

    # endregion
