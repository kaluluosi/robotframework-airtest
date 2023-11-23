from .base import BasePocoLibrary

from poco.drivers.android.uiautomation import AndroidUiautomationPoco


class AndroidUiAutomationPocoLibrary(BasePocoLibrary):
    def _create_poco(self):
        return AndroidUiautomationPoco()
