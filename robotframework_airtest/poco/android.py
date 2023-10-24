from poco.drivers.std import StdPoco
from .std import StdPocoLibrary

from poco.drivers.android.uiautomation import AndroidUiautomationPoco


class AndroidUiAutomationPocoLibrary(StdPocoLibrary):
    def _create_poco(self) -> StdPoco:
        return AndroidUiautomationPoco()
