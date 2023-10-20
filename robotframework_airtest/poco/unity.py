from typing import Tuple
from poco.drivers.std import StdPoco
from poco.drivers.unity3d.unity3d_poco import UnityPoco, DEFAULT_ADDR
from .std import StdPocoLibrary


class UnityPocoLibrary(StdPocoLibrary):
    def __init__(self, addr: Tuple[str, int] = DEFAULT_ADDR, **kwargs) -> None:
        super().__init__(addr, **kwargs)

    def _create_poco(self) -> StdPoco:
        """
        Unity 的 Poco-SDK开出来的端口是 5001，所以只能用UnityPoco去连接。

        不需要设置 `unity_editor=True` 参数，我已经在 `robotframework_airtest.device.connects.impl.unity` 里做了处理，
        能够准确捕获game窗口。

        Returns:
            StdPoco: Poco实例
        """
        return UnityPoco(self.addr, **self.kwargs)
