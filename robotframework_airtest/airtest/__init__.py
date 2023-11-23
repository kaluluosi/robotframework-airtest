"""
author:        kaluluosi111 <kaluluosi@gmail.com>
date:          2023-11-23 17:36:57
Copyright © Kaluluosi All rights reserved
"""
import os
from airtest.core.api import (
    Template,
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
from typing import Optional, Tuple, Union

Point = Tuple[float, float]
TargetType = Union[Point, str]


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

    @deco.keyword("点击")
    def touch(
        self,
        target: TargetType,
        times: int = 1,
        threshold: Optional[float] = None,
        record_pos: Optional[int] = None,
        target_pos: int = TargetPos.MID,
        resolution=(),
        rgb=False,
        scale_max=800,
        scale_step=0.005,
    ):
        v = target
        if isinstance(target, str):
            v = Template(
                os.path.join(self.curdir, target),
                threshold=threshold,
                record_pos=record_pos,
                target_pos=target_pos,
                resolution=resolution,
                rgb=rgb,
                scale_max=scale_max,
                scale_step=scale_step,
            )
        elif isinstance(target, Tuple):
            v = target

        touch(v, times=times)
