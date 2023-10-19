from poco.drivers.std import StdPoco
from poco.drivers.unity3d.unity3d_poco import UnityPoco
from .std import StdPocoLibrary


class UnityPocoLibrary(StdPocoLibrary):
    def _create_poco(self) -> StdPoco:
        """Unity 的 Poco-SDK开出来的端口是 5004，所以只能用UnityPoco去连接。

        Returns:
            StdPoco: Poco实例
        """
        return UnityPoco()
