from .base import BasePocoLibrary

from poco.drivers.ios import iosPoco


class IOSPocoLibrary(BasePocoLibrary):
    def _create_poco(self):
        return iosPoco()
