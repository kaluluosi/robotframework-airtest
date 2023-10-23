from airtest.core.device import Device
from robot.api import logger
from airtest.core.api import connect_device
from airtest.core.helper import G
from ..connect_strategy import ConnectStrategyBase


class AndroidConnectStrategy(ConnectStrategyBase):
    def connect(self, auto_start_app=False) -> Device:
        self.device = connect_device(self.device_uri)
        logger.console("设备<{device}>：连接".format(device=self.device_uri))
        self.device.unlock()
        self.device.wake()
        logger.console("启动APP：{}".format(auto_start_app))
        if auto_start_app:
            if not self.device.check_app(self.pkg_name):
                logger.error(
                    "设备<{device}>：没有安装app<{app}>，启动失败。".format(
                        device=self.device_uri, app=self.pkg_name
                    )
                )
            else:
                logger.info(
                    "设备<{device}>：关闭app<{app}>".format(
                        device=self.device_uri, app=self.pkg_name
                    )
                )
                self.device.stop_app(self.pkg_name)
                logger.info(
                    "设备<{device}>：启动app<{app}>".format(
                        device=self.device_uri, app=self.pkg_name
                    )
                )
                self.device.start_app(self.pkg_name)
        return self.device

    def disconnect(self):
        if self.is_connected:
            if self.pkg_name:
                try:
                    self.device.stop_app(self.pkg_name)
                except Exception:
                    logger.warn("APP没有运行，没有停止。")

            G.DEVICE_LIST.remove(self.device)
