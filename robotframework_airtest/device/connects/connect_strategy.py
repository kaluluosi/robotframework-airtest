from abc import ABC, abstractmethod
from airtest.core.device import Device
from airtest.core.helper import G


class ConnectStrategyBase(ABC):
    def __init__(self, device_uri: str, pkg_name: str):
        """初始化连接策略

        Args:
            device_uri (str): 连接字符串  例子:Windows:///?title_re=com \n
            pkg_name (str): 包名 例如:com.xy.xyx，如果是pc客户端则传递可执行文件路径
        """
        self.device_uri = device_uri
        self.pkg_name = pkg_name.strip('"') if pkg_name is not None else ""
        self.device: Device = None

    @abstractmethod
    def connect(self, auto_start_app: bool = False) -> Device:
        """
        连接过程
        """
        ...

    @abstractmethod
    def disconnect(self):
        """断开设备后的处理。此方法是个虚方法需要具体设备具体实现

        Raises:
            NotImplementedError: 没有实现
        """
        ...

    @property
    def is_connected(self):
        return self.device and self.device in G.DEVICE_LIST
