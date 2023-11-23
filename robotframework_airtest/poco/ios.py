from .std import StdPocoLibrary

from poco.drivers.ios import iosPoco


class IOSPocoLibrary(StdPocoLibrary):
    def _create_poco(self):
        return iosPoco()
