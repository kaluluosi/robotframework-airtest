from .base import BasePocoLibrary
from poco.drivers.cocosjs import CocosJsPoco, CocosJsPocoAgent


class CocosJsPocoLibrary(BasePocoLibrary):
    def _create_poco(self):
        agent = CocosJsPocoAgent(self.addr[1])
        poco = CocosJsPoco(agent)
        return poco
