from poco.drivers.std import DEFAULT_ADDR
from .std import IPAddress, StdPocoLibrary

from poco.drivers.ue4 import UE4Poco


class UE4PocoLibrary(StdPocoLibrary):
    def __init__(
        self, addr: IPAddress = DEFAULT_ADDR, ue4_editor: bool = False, **kwargs
    ) -> None:
        super().__init__(addr, **kwargs)
        self.ue4_editor = ue4_editor

    def _create_poco(self):
        return UE4Poco(self.addr, ue4_editor=self.ue4_editor)
