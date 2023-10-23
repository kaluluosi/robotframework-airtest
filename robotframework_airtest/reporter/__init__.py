"""
Airtest日志导出报告监听器
从AxonPoco中剥离
如果robot没有指明这个监听器，那么将不会导出airtest的报告也不会插入到robot的报告里
"""
import os
from shutil import rmtree
import time
from airtest.core.helper import set_logdir

from airtest.core.settings import Settings
from airtest.core.api import G, snapshot
from robot.libraries.BuiltIn import BuiltIn
from robot.api import logger


class AirtestReporter:
    """
    Airtest日志导出报告监听器
    NOTE: 如果robot没有指明这个监听器，那么将不会导出airtest的报告也不会插入到robot的报告里

    通过再robot命令后面追加
    `--listener robotframework_airtest.reporter.AirtestReporter` 可以在测试执行的时候生成airtest的测试报告。


    """

    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self, recording: bool = True):
        logger.debug("Airtest报告生成器初始化: recording {}".format(recording))
        self._recording = recording
        Settings.RECORDING = self._recording

    @property
    def log_dir(self) -> str:
        """
        获取当前Airtest测试用例日志截图输出目录
        """
        return Settings.LOG_DIR

    @property
    def out_dir(self) -> str:
        """robotframework 日志和报告输出目录

        Returns:
            str: 目录路径
        """
        out_dir = BuiltIn().get_variable_value("${OUTPUT DIR}")
        out_dir = out_dir if out_dir else "Logs"
        return out_dir

    @property
    def test_name(self) -> str:
        variables = BuiltIn().get_variables()
        return variables["${TEST NAME}"]

    @property
    def suit_name(self) -> str:
        variables = BuiltIn().get_variables()
        return variables["${SUITE NAME}"]

    @property
    def test_documenmt(self) -> str:
        variables = BuiltIn().get_variables()
        return variables["${TEST DOCUMENTATION}"]

    def _create_airtest_info_file(self):
        metadata = BuiltIn().get_variable_value("${SUITE METADATA}")
        author = metadata["作者"] if "作者" in metadata else "佚名"

        lines = []
        lines.append("__title__ = '{}'".format(self.test_name))
        lines.append("__author__ = '{}'".format(author))
        lines.append("__desc__ = '{}'".format(self.test_documenmt))
        script_info_file = os.path.join(self.log_dir, self.test_name + ".py")
        with open(script_info_file, "w", encoding="utf-8") as f:
            f.writelines([line + "\n" for line in lines])

    def start_test(self, name, attrs):
        log_dir = os.path.join(
            self.out_dir,
            ".airtest",
            self.suit_name,
            self.test_name + ".air",
        )
        Settings.LOG_DIR = log_dir
        logger.console("Airtest Reporter设置Airtest输出日志目录 {}".format(Settings.LOG_DIR))
        if os.path.exists(Settings.LOG_DIR):
            # 截图和录像会越来越多，先删掉处理，以后jenkins构建会自动打包生成的日志不会丢失。
            # 至于以后多移动设备跑要怎么处理日志放置，我觉得应该由上层的脚本通过设置robot的输出目录的方式解决，
            # 不应该由框架内部处理
            rmtree(log_dir)
        os.makedirs(log_dir)

        set_logdir(Settings.LOG_DIR)
        # 写一个 py文件用来供airtest生成报告
        self._create_airtest_info_file()

        if self._recording:
            try:
                if G.DEVICE:
                    G.DEVICE.start_recording()
                    logger.console("设备开始录像")
                else:
                    logger.warn("设备开始录像：这个时候没有设备连接无法录像")

            except Exception as e:
                logger.warn(e)
                logger.warn("要去链接里下载对应的dll放到项目根目录才能支持录像")

    def end_test(self, name, attrs):
        if self._recording:
            if G.DEVICE and self._recording:
                # timestamp = str(int(time.time()))
                # file_name = "{}.mp4".format(timestamp)
                # out_file = os.path.join(Settings.LOG_DIR, file_name)

                G.DEVICE.stop_recording()
                logger.console("录制结束")
            else:
                logger.warn("录像结束：这个时候没有设备连接")

        self._airtest_report(name, attrs)
        logger.console("生成Airtest报告")

    def end_keyword(self, name, attrs):
        if attrs["status"] == "FAIL":
            try:
                snapshot(msg="{}:失败截图".format(name))
            except Exception:
                pass

    def _airtest_report(self, name, attrs):
        # 如果测试用里
        if attrs["status"] == "FAIL":
            msg: str = attrs["message"]
            G.LOGGER.log(
                "info", {"name": "Final Error", "traceback": msg}, 0, time.time()
            )

        from airtest.report.report import get_parger, main as report_main
        from argparse import ArgumentParser

        ap = ArgumentParser()
        log_root = self.log_dir
        report_path = os.path.join(log_root, self.test_name + ".log", "log.html")
        args = get_parger(ap).parse_args(
            ["--log_root", log_root, "--export", log_root, log_root]
        )
        report_main(args)
        outfile_url = report_path.replace(self.out_dir, "")
        if outfile_url.startswith(os.path.sep):
            outfile_url = outfile_url.replace(os.path.sep, "", 1)  # 删除掉第一个\\ 分隔符
        BuiltIn().set_test_documentation(
            "[{}|Airtest报告]".format(outfile_url), append=True
        )
