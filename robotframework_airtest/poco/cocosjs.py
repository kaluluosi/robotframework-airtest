from .std import StdPocoLibrary
from poco.drivers.cocosjs import CocosJsPoco, CocosJsPocoAgent


class CocosJsPocoLibrary(StdPocoLibrary):
    def _create_poco(self):
        agent = CocosJsPocoAgent(self.addr[1])
        poco = CocosJsPoco(agent)
        return poco
