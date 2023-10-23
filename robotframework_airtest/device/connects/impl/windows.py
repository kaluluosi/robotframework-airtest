import os
import sys
import shutil
import subprocess
import time
import types

import cv2
import pkg_resources
import robotframework_airtest

from tempfile import TemporaryDirectory
from threading import Lock, Thread

from airtest.core.api import connect_device
from airtest.core.device import Device
from airtest.core.helper import G
from airtest.core.win.win import Windows

from robot.api import logger

from ..connect_strategy import ConnectStrategyBase


DLL_PATH = pkg_resources.resource_filename(robotframework_airtest.__package__, "dll")
# 获取当前环境变量PATH
path = os.environ["PATH"]

# 添加路径到环境变量PATH
new_path = f"{DLL_PATH};" + path
os.environ["PATH"] = new_path


def windows_wrapper(win_device: Windows):
    """windows设备对象包装器，用来Monkey Path其start_recording,stop_recording方法。\
       因为我不想重新写一个自己的connect_deivce，所以沿用原生connect_device方法。\
       然后强行修改其返回的device:Windows 对象让其start_recording,stop_recording方法能够正常运作。

    Args:
        win_device (Windows): 窗口设备
    """

    def start_recording(self: Windows, output: str = None, *args, **kwargs):
        if getattr(self, "_recording"):
            return

        self._recording = True
        self._record_out_file = output

        def _recording():
            codec = cv2.VideoWriter_fourcc(*"avc1")

            tmp_dir_obj = TemporaryDirectory()
            tmp_dir = tmp_dir_obj.name
            logger.console(tmp_dir)

            # 有可能会截图失败,重试10次
            resolution = ()
            try_times = 10
            while try_times > 0:
                try:
                    # get_current_resolution 得到的 分辨率 根 实际截图的分辨率有可能不一致,因此通过截图来获取正确的分辨率
                    height, width, chanels = self.snapshot().shape
                    resolution = (width, height)
                    break
                except Exception:
                    time.sleep(1)
                    try_times -= 1
                    continue

            if resolution == ():
                resolution = self.get_current_resolution()

            tmp_out_file = os.path.join(tmp_dir, "record.mp4")
            out = cv2.VideoWriter(tmp_out_file, codec, 12, resolution)

            # frame_index = 0
            while self._recording:
                try:
                    img = self.snapshot(quality=80)
                    out.write(img)
                    time.sleep(1 / 30.0)
                except Exception as e:
                    logger.console(e)

            out.release()
            out_file = self._record_out_file
            if out_file is None:
                raise TypeError("outpot 是 None")
            shutil.copy(tmp_out_file, out_file)
            logger.console("录制结束,保存到{}".format(out_file))

        self._recorder = Thread(target=_recording)
        self._recorder.start()

    def stop_recording(self: Windows, output: str = None, is_interrupted: bool = False):
        if output:
            self._record_out_file = output
        self._recording = False
        if self._recorder:
            self._recorder.join()
        else:
            return False

    def _snapshot(self, *args, **kwargs):
        """调用原始设备的截图截取每一帧

        Returns:
            [type]: [description]
        """
        self._lock.acquire()
        # logger.console("snap lock")
        try:
            ret = Windows.snapshot(self, *args, **kwargs)
            self._lock.release()
            # logger.console("snap lock inner release")
            return ret
        except Exception:
            # logger.console("snap lock final release")
            self._lock.release()

    win_device._recording = False
    win_device._recorder = None
    win_device._lock = Lock()

    win_device.start_recording = types.MethodType(start_recording, win_device)
    win_device.stop_recording = types.MethodType(stop_recording, win_device)
    win_device.snapshot = types.MethodType(_snapshot, win_device)

    return win_device


class WindowsConnectStrategy(ConnectStrategyBase):
    def connect(self, auto_start_app: bool = False) -> Device:
        if auto_start_app:
            # 尝试连接一下看是不是正有一个客户端开着
            try:
                connect_device(self.device_uri)
            except Exception:
                logger.console("当前没有正在运行的客户端,尝试启动一个")
                logger.console(
                    "设备<{device}>：启动app<{app}>".format(
                        device=self.device_uri, app=self.pkg_name
                    )
                )
                app_path = os.path.dirname(self.pkg_name)
                app_name = os.path.basename(self.pkg_name)
                logger.console("cwd:{} exe:{}".format(app_path, app_name))
                subprocess.Popen(app_name, cwd=app_path, shell=True)
                logger.console("客户端启动成功")

        logger.console("开始尝试连接设备...")
        try_time = 10

        while try_time > 0:
            try:
                self.device = connect_device(self.device_uri)
                self.device.focus_rect = [0, 28, 0, 0]

                self.device = windows_wrapper(self.device)
                logger.console("连接设备成功")
                return self.device
            except Exception as e:
                logger.warn(e)
                time.sleep(5)
                logger.warn(
                    "连接<{device_uri}>失败，重试 {try_time}".format(
                        device_uri=self.device_uri, try_time=try_time
                    )
                )
                try_time -= 1
                continue

    def disconnect(self):
        if self.is_connected:
            self.device.kill()
            logger.info("断开设备")
            G.DEVICE_LIST.remove(self.device)
