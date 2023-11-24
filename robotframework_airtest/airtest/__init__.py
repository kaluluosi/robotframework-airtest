"""
author:        kaluluosi111 <kaluluosi@gmail.com>
date:          2023-11-23 17:36:57
Copyright © Kaluluosi All rights reserved
"""
import os
from airtest.core.api import (
    Template as AirTemplate,
    touch,
    wait,
    swipe,
    exists,
    text,
    keyevent,
    snapshot,
    sleep,
    assert_exists,
    assert_not_exists,
    assert_equal,
    assert_not_equal,
)
from airtest.utils.transform import TargetPos

from robot.libraries.BuiltIn import BuiltIn
from robot.api import deco
from robot.utils import timestr_to_secs

from typing import Any, Callable, Optional, Tuple, Union

Point = Tuple[float, float]
TargetType = Union["Template", Point, str]


class Template(AirTemplate):
    def __init__(
        self,
        filename: str,
        threshold: Optional[float] = None,
        target_pos=TargetPos.MID,
        record_pos: Optional[Point] = None,
        resolution=...,
        rgb: bool = False,
        scale_max: int = 800,
        scale_step: float = 0.005,
    ):
        """
        Args:
            filename (str): 文件名，相对于robot脚本的路径 \n
            threshold (Optional[float], optional): 识别阈值，越高越严格. Defaults to None. \n
            record_pos (Optional[Point], optional): 录制坐标. Defaults to None. \n
            target_pos (int, optional): 点击目标坐标偏移. Defaults to TargetPos.MID. \n
            resolution (tuple, optional): 分辨率. Defaults to (). \n
            rgb (bool, optional): 是否rgb三通道识别，默认是将图片转单通道灰度图，灰度更快. Defaults to False. \n
            scale_max (int, optional): 最大缩放倍数. Defaults to 800. \n
            scale_step (float, optional): 缩放步进. Defaults to 0.005. \n
        """
        super().__init__(
            filename,
            threshold,
            target_pos,
            record_pos,
            resolution,
            rgb,
            scale_max,
            scale_step,
        )
        self.filename = os.path.join(self.curdir, filename)

    @property
    def curdir(self):
        suit_source = BuiltIn().get_variable_value("${SUITE SOURCE}")
        curdir = os.path.dirname(suit_source)
        return curdir


class AirtestLibrary:
    ROBOT_LIBRARY_SCOPE = "TEST CASE"
    ROBOT_LIBRARY_FORMAT = "rsST"
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self) -> None:
        pass

    @property
    def curdir(self):
        suit_source = BuiltIn().get_variable_value("${SUITE SOURCE}")
        curdir = os.path.dirname(suit_source)
        return curdir

    def template(
        self,
        target: TargetType,
        threshold: Optional[float] = None,
        target_pos: int = TargetPos.MID,
        record_pos: Optional[Point] = None,
        resolution: Any = None,
        rgb: bool = False,
        scale_max: int = 800,
        scale_step: float = 0.005,
    ):
        """
        创建Airtest Template对象

        `Target` 的路径是`robot`脚本的相对路径，也就是说你只需要将图片放到 `robot`
        相同目录下然后就可以相对路径的方式引用。

        例子：

        test.robot、btn_start.png 这两个文件都在同一个目录，
        那么`Template`可以直接引用`btn_start.png`，不需要复杂的转换。

        ```robotframework
        ${开始按钮}     Template    btn_start.png
        ```



        Args:
            target (TargetType): _description_
            threshold (Optional[float], optional): _description_. Defaults to None.
            target_pos (int, optional): _description_. Defaults to TargetPos.MID.
            record_pos (Optional[Point], optional): _description_. Defaults to None.
            resolution (Any, optional): _description_. Defaults to None.
            rgb (bool, optional): _description_. Defaults to False.
            scale_max (int, optional): _description_. Defaults to 800.
            scale_step (float, optional): _description_. Defaults to 0.005.

        Returns:
            _type_: _description_
        """
        if isinstance(target, str):
            return Template(
                target,
                threshold,
                target_pos,
                record_pos,
                resolution,
                rgb,
                scale_max,
                scale_step,
            )
        elif isinstance(target, Template) or isinstance(target, Tuple):
            return target

    @deco.keyword("点击")
    def touch(
        self,
        target: TargetType,
        times: int = 1,
    ):
        """
        点击`Touch`

        NOTE: `threashold` 及其后面的参数可以无视，因为都会默认使用`airtest.core.settings:Settings`的配置。

        Args:
            target (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            times (int, optional): 点击次数. Defaults to 1.
        """
        v = self.template(target)
        touch(v, times=times)

    @deco.keyword("等待")
    def wait(
        self,
        target: TargetType,
        timeout: str,
        interval: float = 0.5,
        interval_func: Optional[Callable] = None,
    ):
        """
        等待目标出现 `Wait`

        Args:
            target (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            timeout (str): 超时，支持`robot`的时间字符串，如'1h 10s', '01:00:10' and '42'等，具体可以看`timestr_to_secs`。
            interval (float, optional): 等待检查间隔. Defaults to 0.5.
            interval_func (Optional[str], optional): 每次检查失败时调用回调. Defaults to None.

        """
        timeout_secs = timestr_to_secs(timeout)
        v = target

        if interval_func is not None:

            def _callback():
                return BuiltIn().run_keyword(interval_func)

            invoker = _callback
        else:
            invoker = None

        wait(v, timeout_secs, interval=interval, intervalfunc=invoker)

    def swipe(
        self,
        target1: TargetType,
        target2: TargetType,
        vector: Optional[Point] = None,
    ):
        """
        滑动 `Swipe`

        例子

        ```robotframework

        滑动    start_btn.png   list_view
        滑动    start_btn.png   (10,0)
        滑动    (10,10)     vector=(20,20)

        ```

        Args:
            target1 (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            target2 (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            vector (Optional[Point], optional): 方向向量 如`(1,0)`-向右. Defaults to None.
        """
        v1 = self.template(
            target1,
        )
        v2 = self.template(
            target2,
        )
        swipe(v1, v2, vector)

    @deco.keyword("存在")
    def exists(self, target: TargetType) -> bool:
        """
        检查目标是否存在

        NOTE: 不会引发异常

        Args:
            target (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。

        Returns:
            bool : 存在返回`true`
        """
        v = self.template(target)
        return exists(v)

    @deco.keyword("输入文字")
    def text(self, _text: str, enter: bool = True):
        """
        输入文字

        Args:
            _text (str): 文字
            enter (bool, optional): 输入完后按回车. Defaults to True.
        """
        text(_text, enter=enter)

    @deco.keyword("按键事件")
    def keyevent(self, keyname: str, *args, **kwargs):
        """
        按键事件

        Args:
            keyname (str): 按键名或者按键码
        """
        keyevent(keyname, *args, **kwargs)

    @deco.keyword("截图")
    def snapshot(
        self,
        filename: Optional[str] = None,
        msg: str = "",
        quality: Optional[int] = None,
        max_size: Optional[int] = None,
    ):
        """
        截图

        Args:
            filename (Optional[str], optional): 默认保存到LOG_DIR. Defaults to None.
            msg (str, optional): 信息. Defaults to "".
            quality (Optional[int], optional): 质量. Defaults to None.
            max_size (Optional[int], optional): 最大尺寸. Defaults to None.

        Returns:
            _type_: _description_
        """
        return snapshot(filename, msg=msg, quality=quality, max_size=max_size)

    @deco.keyword("睡眠")
    def sleep(self, timeout: str):
        """
        睡眠

        Args:
            timeout (str): `robot`时间字符串，如`1h 2m 3s` `2min 3sec` `40 sec`等都能识别。
        """
        secs = timestr_to_secs(timeout)
        sleep(secs)

    @deco.keyword("元素必须存在")
    def assert_exists(self, target: TargetType, msg: str = ""):
        """
        断言 元素必须存在

        Args:
            target (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            msg (str, optional): 信息. Defaults to "".
        """
        v = self.template(target)
        assert_exists(v, msg)

    @deco.keyword("元素必须不存在")
    def assert_not_exists(self, target: TargetType, msg: str = ""):
        """
        断言 元素必须不存在


        Args:
            target (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            msg (str, optional): 信息. Defaults to "".
        """
        v = self.template(target)
        assert_not_exists(v, msg)

    @deco.keyword("必须相等")
    def assert_equal(
        self,
        first: TargetType,
        second: TargetType,
        msg: str = "",
        snapshot: bool = True,
    ):
        """
        断言 必须相等

        Args:
            first (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            second (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            msg (str, optional): 信息. Defaults to "".
            snapshot (bool, optional): 是否截图. Defaults to True.
        """
        assert_equal(first, second, msg=msg, snapshot=snapshot)

    @deco.keyword("必须不相等")
    def assert_not_equal(
        self,
        first: TargetType,
        second: TargetType,
        msg: str = "",
        snapshot: bool = True,
    ):
        """
        断言 必须不相等

        Args:
            first (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            second (TargetType): 目标可以是坐标`Tuple`，也可以是`Template`，也可以是文件名。
            msg (str, optional): 信息. Defaults to "".
            snapshot (bool, optional): 是否截图. Defaults to True.
        """
        assert_not_equal(first, second, msg=msg, snapshot=snapshot)
