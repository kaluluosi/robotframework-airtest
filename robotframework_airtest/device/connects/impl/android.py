from airtest.core.device import Device
from robot.api import logger
from airtest.core.api import connect_device
from airtest.core.helper import G
from ..connect_strategy import ConnectStrategyBase


class AndroidConnectStrategy(ConnectStrategyBase):
    def connect(self, auto_start_app=False) -> Device:
        self.device = connect_device(self.device_uri)
        logger.console(f"设备<{self.device_uri}>：连接")
        self.device.unlock()
        self.device.wake()
        logger.console(f"启动APP：{auto_start_app}")
        if auto_start_app:
            if not self.device.check_app(self.pkg_name):
                logger.error(f"设备<{self.device_uri}>：没有安装app<{self.pkg_name}>，启动失败。")
            else:
                logger.info(f"设备<{self.device_uri}>：关闭app<{self.pkg_name}>")
                self.device.stop_app(self.pkg_name)
                logger.info(f"设备<{self.device_uri}>：启动app<{self.pkg_name}>")
                self.device.start_app(self.pkg_name)
        return self.device

    def disconnect(self):
        if self.is_connected:
            if self.pkg_name:
                try:
                    self.device.stop_app(self.pkg_name)
                except Exception as e:
                    logger.warn(f"APP没有运行，没有停止。{e}")

            G.DEVICE_LIST.remove(self.device)
