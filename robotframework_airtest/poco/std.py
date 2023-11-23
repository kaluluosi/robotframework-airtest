import time

from typing import Optional

from poco.proxy import UIObjectProxy
from poco.drivers.std import StdPoco, DEFAULT_ADDR


from robot.api import logger  # logger是普通的命令行日志器

from .gesture import PendingGestureAction
from .base import BasePocoLibrary, IPAddress


class StdPocoLibrary(BasePocoLibrary[StdPoco]):
    """
    注意：
        所有的的关键字参数里 path 参数都兼容 str和UIObjectProxy。
        也就是说在Robotframework里你可以如下使用：

        例子：
            # 直接用查询字符
            点击元素    btn_start
            # 用UIObjectProxy对象

            ${btn_start}    获取元素    btn_start
            点击元素    ${btn_start}

            # 用界面模型变量
            点击元素    ${Panel.btn_start}
    """

    ROBOT_LIBRARY_SCOPE = "TEST CASE"
    ROBOT_LIBRARY_FORMAT = "rsST"
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(
        self,
        addr: IPAddress = DEFAULT_ADDR,
        **kwargs,
    ) -> None:
        self.ROBOT_LIBRARY_LISTENER = self

        self.addr = addr
        self.kwargs = kwargs

        self._poco: Optional[StdPoco] = None
        self.focusing_elements: list[UIObjectProxy] = []

        # UI监视
        self.ui_watchers: list[str] = []
        self.cur_watcher: str = ""

        self._gesture: Optional[PendingGestureAction] = None

    @property
    def poco(self) -> StdPoco:
        """获取或创建Poco实例

        Returns:
            StdPoco: Poco实例
        """
        if self._poco is None:
            connect_try_times = 0
            max_try_times = 10
            logger.console("创建Poco实例")
            while True:
                try:
                    self._poco = self._create_poco()
                    logger.console("尝试创建Poco...")
                    self._poco.agent.hierarchy.dump()
                    break
                except Exception as e:
                    logger.console(e)
                    if connect_try_times < max_try_times:
                        connect_try_times += 1
                        self._poco = None
                        time.sleep(2)
                        logger.console("Poco连接失败，可能游戏还没有加载完...")
                        logger.console(
                            "尝试重新连接.... {}/{}".format(
                                connect_try_times, max_try_times
                            )
                        )
                    else:
                        logger.warn("多次尝试都失败，请自行检查")
                        raise e

            logger.console("Poco实例创建完毕")
        self._poco.device
        return self._poco

    def _create_poco(self) -> StdPoco:
        """
        XXX: 不同的Poco-SDK PocoManager开出的端口都不一样，所以需要为不同的引擎返回具体的Poco。

        StdPoco连接的端口是15004，但是UnityPoco连接的端口是5004。
        """
        return StdPoco(port=self.addr[1])
