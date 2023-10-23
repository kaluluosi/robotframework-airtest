"""
添加新的连接策略

方法1：源码开发
    如果添加新的设备连接策略，需要在DeviceLibrary包下创建一个新的模块，模块名格式 {小写Platform}.py。
    在这个模块内继承ConnectStrategy实现新的设备连接策略类，其类名格式 {首字母大写Platform}ConnectStrategy。
    然后实现connect和disconnect两个抽象方法。

方法2：Entry Point 插件
    另外开发一个包，继承并实现自己的ConnectStrategy，然后在setup.cfg/setup.py里定义Entry Point，把类传入。
    注意格式：[模块.[模块...]]:[类|函数]
    例如：
        >setup.cfg

        [options.entry_points]
        DeviceLibrary.connect_strategy =
            myplatform = src.myplatform:MyplatformConnectStrategy

        >setup.py

        setup(
            entry_points = {
                "DeviceLibrary.connect_strategy":{
                    "unity" = "src.UnityConnectStrategy"
                }
            }
        )
    当这个包被安装到python环境后，factory函数内会搜索所有注册到DeviceLibrary.connect_strategy入口组的入口，
    找到匹配platform的入口，加载这个入获取ConnectStrategy类，然后用这个类来实例化具体的ConnectStrategy。
"""

from importlib import metadata
from typing import Dict
from urllib.parse import urlparse
from .connect_strategy import ConnectStrategyBase


def get_valid_connect_strategy() -> Dict[str, ConnectStrategyBase]:
    """获取所有支持的连接策略

    Returns:
        Dict[str,ConnectStrategy]: 支持的连接策略
    """
    entry_points = metadata.entry_points().get(
        "robotframework_airtest.device.connect_strategy", []
    )
    all_connect_strategies = {}
    for ep in entry_points:
        connect_strategy = ep.load()
        all_connect_strategies[ep.name] = connect_strategy

    return all_connect_strategies


def factory(device_uri: str, pkg_name: str) -> ConnectStrategyBase:
    """动态加载实现的工厂，用来创建连接策略实例

    Returns:
        ConnectStrategy: 连接策略实例
    """
    res = urlparse(device_uri)
    platform = res.scheme
    all_connect_strategies = get_valid_connect_strategy()
    connect_strategy = all_connect_strategies.get(platform, None)
    if connect_strategy is None:
        raise RuntimeError(f"没有合适的连接策略，不支持 {platform} 平台连接")

    return connect_strategy(device_uri, pkg_name)
