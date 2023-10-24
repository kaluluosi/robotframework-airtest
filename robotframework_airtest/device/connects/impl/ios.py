from typing import cast
from airtest.core.device import Device
from airtest.core.ios import IOS
from robot.api import logger
from airtest.core.api import connect_device
from airtest.core.helper import G
from ..connect_strategy import ConnectStrategyBase


class IOSConnectStrategy(ConnectStrategyBase):
    """
    iOS连接策略
    """

    def connect(self, auto_start_app: bool = False) -> Device:
        self.device = connect_device(self.device_uri)
        self.device = cast(IOS, self.device)
        logger.console(f"设备<{self.device_uri}>：连接")

        self.device.unlock()

        if auto_start_app:
            app_list = self.device.list_app()
            if self.pkg_name not in app_list:
                logger.error(f"设备<{self.device}>：未安装{self.pkg_name}，启动失败")
            else:
                logger.info(f"设备<{self.device}>：关闭app<{self.pkg_name}>")
                self.device.stop_app(self.pkg_name)
                logger.info(f"设备<{self.device}>：启动app<{self.pkg_name}>")
                self.device.start_app(self.pkg_name)

        return self.device

    def disconnect(self):
        if self.is_connected and self.pkg_name:
            try:
                self.device.stop_app(self.pkg_name)
            except Exception as e:
                logger.warn(f"APP没有运行，没有停止：{e}")

            G.DEVICE_LIST.remove(self.device)
