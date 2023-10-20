import math
import os
import re
import time
import types

from shutil import rmtree
from typing import Optional, Union, Tuple, List
from urllib.parse import parse_qsl, urlparse

from poco.proxy import UIObjectProxy
from poco.drivers.std import StdPoco, DEFAULT_ADDR
from poco.utils.simplerpc.rpcclient import RpcClient

from airtest import aircv
from airtest.core.api import keyevent, snapshot
from airtest.core.settings import Settings
from airtest.core.helper import device_platform, set_logdir

from robot.api import logger, deco  # logger是普通的命令行日志器
from robot.output.logger import LOGGER as KW_LOGGER  # 这是robotframework的报告日志器
from robot.libraries.BuiltIn import BuiltIn
from robot.utils import get_link_path, timestr_to_secs

from .gesture import PendingGestureAction, WindowsPendingGestureAction


Point = Tuple[float, float]

# 查询信息hh
QueryInfo = dict

# region 常量

POS_CENTER: Point = (0.5, 0.5)  # 中心点
POS_ZERO: Point = (0, 0)  # 原点

# endregion


def parse_path_to_queryinfos(path: str = None, **attrs) -> List[QueryInfo]:
    """解析 查询链 返回QueryInfos数据供框架使用。

    path参数支持用\\分割拼接多个查询语句做成查询链:

    ```
    btn_start?type=Button\\Label?text=hello
    ```

    上面的效果是获取元素会找btn_start，找到后接着在btn_start下面找Label。


    Args:
        path (str, optional): 查询链. Defaults to None.

    Returns:
        List[QueryInfo]: 解析出来的每一段查询信息
    """
    # logger.console("parsing:{} {}".format(path, attrs))
    query_infos: list[QueryInfo] = []
    if path is None:
        query_info = {"name": None, "attrs": attrs}
        query_infos.append(query_info)
    else:
        paths: list[str] = path.split("\\")
        for index, _path in enumerate(paths):
            d = urlparse(_path)
            path = d.path if d.path else None
            ext_attrs = dict(parse_qsl(d.query))
            query_info = {"name": path, "attrs": ext_attrs}
            if index == len(paths) - 1:
                query_info["attrs"].update(attrs)
            query_infos.append(query_info)

    return query_infos


class StdPocoLibrary:
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
        addr: Tuple[str, int] = DEFAULT_ADDR,
        **kwargs,
    ) -> None:
        self.ROBOT_LIBRARY_LISTENER = self

        self.addr = addr
        self.kwargs = kwargs

        self._poco: StdPoco = None
        self.focus_elements: list[UIObjectProxy] = []

        # UI监视
        self.ui_watchers: list[str] = []
        self.cur_watcher: str = ""

        self._gesture: PendingGestureAction = None

    # region 属性
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
                            "尝试重新连接.... {}/{}".format(connect_try_times, max_try_times)
                        )
                    else:
                        logger.warn("多次尝试都失败，请自行检查")
                        raise e

            logger.console("Poco实例创建完毕")

            # 强行给_poco添加一个offspring方法方便_query方法的统一处理
            self._poco.offspring = lambda name, **attrs: self._poco(name, **attrs)

        return self._poco

    @property
    def focus_element(self) -> Union[UIObjectProxy, StdPoco]:
        """获取当前聚焦元素

        Returns:
            UIObjectProxy: 元素对象
        """
        # 如果聚焦栈不为空
        if self.focus_elements:
            # 栈顶元素就是当前聚焦的元素
            return self.focus_elements[-1]
        # 不然就返回根元素
        return self.poco

    @property
    def airtest_log_dir(self) -> str:
        """
        获取当前Airtest测试用例日志截图输出目录
        """
        return Settings.LOG_DIR

    @property
    def output_dir(self) -> str:
        """robotframework 日志和报告输出目录

        Returns:
            str: 目录路径
        """
        variables = BuiltIn().get_variables()
        out_dir = variables["${OUTPUT DIR}"]
        return out_dir

    @property
    def test_name(self) -> str:
        """获取测试用例名字

        Returns:
            str: 名字
        """
        variables = BuiltIn().get_variables()
        return variables["${TEST NAME}"]

    @property
    def suit_name(self) -> str:
        """获取测试集名

        Returns:
            str: 测试集名
        """
        variables = BuiltIn().get_variables()
        return variables["${SUITE NAME}"]

    @property
    def test_documenmt(self) -> str:
        """获取测试的文档说明

        Returns:
            str: 文档说明
        """
        variables = BuiltIn().get_variables()
        return variables["${TEST DOCUMENTATION}"]

    # endregion

    # region 私有函数

    def _create_poco(self) -> StdPoco:
        """
        XXX: 不同的Poco-SDK PocoManager开出的端口都不一样，所以需要为不同的引擎返回具体的Poco。

        StdPoco连接的端口是15004，但是UnityPoco连接的端口是5004。
        """
        return StdPoco(port=self.addr[1])

    @deco.not_keyword
    def _disable_keyword_logging(self):
        """关闭关键字日志"""

        def do_nothing(*args, **kwargs):
            """
            空调用只是用来关闭日之用的
            """
            pass

        self._logging_methods = (KW_LOGGER.start_keyword, KW_LOGGER.end_keyword)
        KW_LOGGER.start_keyword = types.MethodType(do_nothing, KW_LOGGER)
        KW_LOGGER.end_keyword = types.MethodType(do_nothing, KW_LOGGER)

    @deco.not_keyword
    def _enable_keyword_logging(self):
        """打开关键字日志"""
        KW_LOGGER.start_keyword, KW_LOGGER.end_keyword = self._logging_methods

    def _start_keyword(self, name: str, attrs: dict):
        if self._poco:
            for ui_watcher in self.ui_watchers:
                if name == self.cur_watcher.lower().strip():
                    logger.console("出现递归，需要检查一下关键字批[{}]是不是没有写判断逻辑！".format(ui_watcher))
                else:
                    self.cur_watcher = ui_watcher
                    self._disable_keyword_logging()
                    BuiltIn().run_keyword(ui_watcher)
                    self._enable_keyword_logging()
        logger.console(
            "执行 {} {}".format(name, attrs["args"] if "args" in attrs else {})
        )

    def _start_test(self, name, attrs: dict):
        # 用例开始的时候也清理一次ui watcher，因为如果调试的时候意外中断可能会导致没有清理
        self.focus_elements.clear()
        if self.airtest_log_dir is None:
            # 如果监听器没有设置airtest输出日志目录，那么就由库自己来设置
            # 因为有可能robot命令没有加入监听器，跑一个不需要输出airtest日志的测试
            # 如果加了监听器那么就不会走到这里
            self._setup_airtest_setting(name)

    def _setup_airtest_setting(self, testname: str):
        """
        初始化Airtest报告输入日志
        """
        # airtest用例的输出目录在robotframework输出目录下面，以用例名为目录保存
        # 如果LOG_DIR没有被监听器设置，那么久由库自己设置主要是为了提供截图存放路径
        Settings.LOG_DIR = os.path.join(self.output_dir, ".airtest", "robot_snap")
        if os.path.exists(Settings.LOG_DIR):
            # 删掉日志目录，因为日志截图会越来越多，先删掉处理
            rmtree(Settings.LOG_DIR)
        os.makedirs(Settings.LOG_DIR)
        logger.console("PocoLibrary 设置截图目录 {}".format(Settings.LOG_DIR))
        set_logdir(Settings.LOG_DIR)

    def _end_test(self, name: str, attrs: dict):
        """测试结束的时候清理掉监控和聚焦元素栈"""
        self.ui_watchers.clear()
        self.focus_elements.clear()

        if attrs["status"] == "FAIL":
            self.snap("失败截图")

    def _query(self, path=None, **attrs) -> UIObjectProxy:
        """基础查询方法，用来处理查询链语句。**attrs 最终会用于查询最后一个节点。
        例如：
        _query("button?text=mybutton\\label?text=mylabel",anchor=[0.5,0.5]) \
        那么 anchor这个额外查询参数只会作用于label的查询。
        Args:
            path (Query, optional): 查询链语句. Defaults to None.

        Returns:
            UIObjectProxy: 找到的元素
        """

        # 如果传进来就是一个元素实例，那么就直接返回不用查了。
        if isinstance(path, UIObjectProxy):
            return path

        queryinfos = parse_path_to_queryinfos(path, **attrs)

        # 先获取第一个查询信息
        queryinfo = queryinfos[0]
        # 在当前聚焦元素下查询第一个元素
        node: UIObjectProxy = self.focus_element.offspring(
            queryinfo["name"], **queryinfo["attrs"]
        )
        # 接着往下查询
        for queryinfo in queryinfos[1:]:
            node = node.offspring(queryinfo["name"], **queryinfo["attrs"])
        return node

    def _robot_snap(self):
        """
        这个截图方法不会在airtest的日志里产生记录，只会在rb日志里产生记录，是更底层的截图实现
        """
        if self.poco is None:
            return
        try:
            screen = self.poco.device.snapshot(quality=Settings.SNAPSHOT_QUALITY)
            _, filepath = self._log_snap()

            if filepath is None:
                return

            aircv.imwrite(filepath, screen, Settings.SNAPSHOT_QUALITY)
        except Exception as e:
            logger.warn("_robot_snap {}".format(e))

    def _log_snap(self, *args) -> Tuple[str, str]:
        """打截图日志，只是产生robotframework的截图超链日志，本身并不截图。"""
        if self.airtest_log_dir is None:
            # 意味本次测试输出airtest日志
            return None, None

        filename = "%(time)d.jpg" % {"time": time.time() * 1000}
        filepath = os.path.join(self.airtest_log_dir, filename)
        link = get_link_path(filepath, self.output_dir)
        logger.info(
            '<a href="%s"><img src="%s" width="%s"></a>' % (link, link, 720), html=True
        )
        return filename, filepath

    # endregion

    # region 关键字定义

    @deco.keyword("监控UI")
    def register_ui_watchers(self, keyword: str):
        """
        注册监控UI关键字，每次其他关键字调用的时候都会执行keyword
        """
        # 监控的关键字不打印到rb日志里，以防嵌套过多日志格式出错无法生成报告
        # 防止重复注册监控
        if keyword not in self.ui_watchers:
            self.ui_watchers.append(keyword)

    @deco.keyword("取消监控UI")
    def unregister_ui_watchers(self, keyword: str):
        """
        撤销注册的keyword
        """
        if keyword in self.ui_watchers:
            self.ui_watchers.remove(keyword)

    @deco.keyword("如果 ${condition} 那么 ${keyword}")
    def if_then(self, condition: str, keyword: str):
        """符合中文语义的条件执行，功能类似 run keyword if 关键字，不同的是 condition同时支持 变量和关键字，
        run keyword if 的condition只支持变量。这个关键字十分适合跟监控UI关键字一同工作。

        例子：
            # 直接利用界面模型来做判断

            如果 LoginView.界面存在 那么 LoginView.点击BtnClose

            # 用bool值做判断
            ${界面存在}     loginView.界面存在

            如果 ${界面存在} 那么 那么 LoginView.点击BtnClose

            #跟监控UI关键字一起组合

            监控UI    如果 LoginView.界面存在 那么 LoginView.点击BtnClose

        Args:
            condition (str): 条件

            keyword (str): 关键字
        """
        logger.console(f"{condition} {keyword}")
        try:
            condition_flag = BuiltIn().evaluate(condition)
        except Exception:
            condition_flag = BuiltIn().run_keyword(condition)

        BuiltIn().run_keyword_if(condition_flag, keyword)

    @deco.keyword("聚焦元素")
    def select_element(self, path=None, **attrs):
        """将聚焦元素、取消聚焦元素之间的元素查找范围限制在所聚焦的元素内部。

        Args:
            path (str|UIObjectProxy, optional): 要聚焦的元素. Defaults to None.
        """
        if isinstance(path, UIObjectProxy):
            logger.debug("聚焦元素-UIObjectProxy <{}:{}>".format(str(path), attrs))
            self.focus_elements.append(path)
        else:
            logger.debug("聚焦元素-路径 {}:{}>".format(str(path), attrs))
            element = self._query(path, **attrs)
            self.focus_elements.append(element)
        logger.debug(
            "聚焦元素 {} {}".format(self.focus_element, self.focus_element.get_name())
        )
        logger.debug(self.focus_elements)

    @deco.keyword("结束聚焦元素")
    def end_select_element(self):
        """
        结束聚焦元素会释放当前选中的元素，并选中上一次选中的元素。如果要完全取消聚焦，应该去调用取消聚焦，取消聚焦关键字会清空所有聚焦元素记录。
        """
        if self.focus_elements:
            e = self.focus_elements.pop()
            logger.debug("结束聚焦元素 {}".format(e))
            logger.debug("聚焦元素 {}".format(self.focus_element))
        else:
            logger.debug("聚焦元素栈是空的")
        logger.debug(self.focus_elements)

    @deco.keyword("取消聚焦")
    def release_all_selected_selement(self):
        """
        强制取消所有聚焦
        """
        if self.focus_elements:
            self.focus_elements.clear()

    @deco.keyword("获取元素")
    def find_element(self, path=None, **attrs) -> UIObjectProxy:
        """查询获取元素

        Args:
            path (str, optional): 查询路径. Defaults to None.

        Returns:
            UIObjectProxy: 返回的元素对象
        """
        return self._query(path, **attrs)

    @deco.keyword("获取元素的父元素")
    def get_parent(self, path=None, **attrs) -> UIObjectProxy:
        """获取元素的父元素

        Args:
            path ([type], optional): [description]. Defaults to None.

        Raises:
            Exception: [description]

        Returns:
            UIObjectProxy: [description]
        """
        return self._query(path, **attrs).parent()

    @deco.keyword("获取元素的孩子")
    def get_children(self, path=None, **attrs) -> UIObjectProxy:
        """获取元素的直接孩子

        Args:
            path (str|UIObjectProxy, optional): 路径或者元素对象. Defaults to None.

        Returns:
            UIObjectProxy: 返回
        """
        if isinstance(path, UIObjectProxy):
            return path.children()
        else:
            element = self._query(path, **attrs)
            return element.children()

    @deco.keyword("点击元素")
    def click_element(self, path=None, focus: Point = POS_CENTER, **attrs):
        """点击元素

        Args:
            path (str|UIObjectProxy, optional): 路径或元素对象. Defaults to None.

            focus (list, optional): 焦点. Defaults to [0.5, 0.5].
        """
        element = self._query(path, **attrs)
        self._robot_snap()
        element.click(focus)
        logger.info("点击 <{}:{}> {}".format(str(path), attrs, focus))

    @deco.keyword("长按元素")
    def long_click_element(self, path=None, duration: float = 2.0, **attrs):
        """长按元素

        Args:
            path (str|UIObjectProxy, optional): 路径或元素对象. Defaults to None.
            focus (list, optional): 焦点. Defaults to [0.5, 0.5].
        """
        element = self._query(path, **attrs)
        self._robot_snap()
        element.long_click(duration)
        logger.info("长按 <{}:{}> {}秒".format(str(path), attrs, duration))

    @deco.keyword("输入文字")
    def input_text(self, path=None, text: str = "", keyboard: bool = False, **attrs):
        """输入文字，主要用于文本框输入。\
            keyboard参数是用按键事件来输入，有时候有些控件实现只有按键事件触发的时候才开始输入。

        Args:
            path (str|UIObjectProxy, optional): 路径或者元素对象. Defaults to None.
            text (str, optional): 文本. Defaults to "".
            keyborad (bool, optional): 模拟键盘按键输入，但是只能输入键盘字母，不支持中文.
            Defaults to False.
        """
        element = self._query(path, **attrs)
        if not keyboard:
            element.set_text(text)
        else:
            element.click(POS_CENTER)
            self.input(text)
        logger.info("输入文字 <{}:{}> : {}".format(str(path), attrs, text))
        self._robot_snap()

    @deco.keyword("获取文字")
    def get_text(self, path=None, **attrs) -> str:
        """获取元素上的文字

        Args:
            path (str|UIObjectProxy, optional): 路径或元素对象. Defaults to None.

        Returns:
            str: 文本
        """
        return self._query(path, **attrs).get_text()

    @deco.keyword("点击屏幕")
    def click_screen(self, pos: Point = POS_CENTER):
        self._robot_snap()
        self.poco.click(pos)

    @deco.keyword("双指手势")
    def pinch(
        self,
        direction: str = "in",
        percent: float = 0.6,
        duration: float = 2.0,
        dead_zone: float = 0.1,
    ):
        """两指捏合拉开手势

        Args:
            direction (str, optional): 方向 'in'向内,'out'向外. Defaults to "in".\n
            percent (float, optional): 手势半径，屏幕百分比. Defaults to 0.6.\n
            duration (float, optional): 持续时间，越小操作速度越快. Defaults to 2.0.\n
            dead_zone (float, optional): 手势内半径. Defaults to 0.1.\n

        Returns:
            [type]: [description]
        """
        self.poco.pinch(direction, percent, duration, dead_zone)

    @deco.keyword("调用GM命令")
    def send_gm(self, gm_code: str, *args):
        """调用前端gm命令接口

        例子：
            小英雄Poco的调用GM命令关键字支持以下几种方式：\n
            调用GM命令    设置金币数量    Money    1000    ——根据GM配置表里的名字调用，
            基本上就是等同点了GM面板上的按钮了\n
            调用GM命令    $set    Money    1000        ——就跟在聊天栏里发送指令一样，这是服务端指令\n
            调用GM命令    /ftask                       ——这是客户端指令\n
        Args:
            gm_code (str): GM指令名，配置表或GM面板上显示的中文名
        """
        return self.poco_rpc_call("send_gm", gm_code, *args)

    @deco.keyword("登出")
    def logout(self):
        """登出游戏，回到登录界面。"""
        self.poco_rpc_call("logout")

    @deco.keyword("登录")
    def login(
        self,
        username: str = None,
        password: str = "",
        serverid: int = None,
        auto_logout: bool = True,
    ):
        """登录到目标服务器。如果当前已经登录进游戏了，在此调用这个关键字会执行登出，然后再登入，因此不需要考虑先登出再调用。
        登录成功后会设置全局变量 ${username} 你可以通过这个变量获取当前账号名。

        Args:
            username (str, optional): 用户名. Defaults to None.
            password (str, optional): 密码. Defaults to None.
            serverid (int, optional): 目标服务器. Defaults to None.
            auto_logout (int, optional): 是否登录前执行一次登出. Defaults to None.
        Returns:
            str： 返回用户名
        """
        if auto_logout:
            self.logout()
        if username is None:
            username = self.create_usename()
        logger.console(
            "登录接口调用 uesrname:{} password:{} serverid:{}".format(
                username, password, serverid
            )
        )
        self.poco_rpc_call("login", username, password, serverid)
        BuiltIn().set_global_variable("${username}", username)
        BuiltIn().set_test_message(f"测试账号：{username}", True)

        return username

    @deco.keyword("元素存在")
    def exists(self, path=None, **attrs) -> bool:
        """元素如果存在返回True，不会抛出异常。

        Args:
            path (Query, optional): 路径或元素对象. Defaults to None.

        Returns:
            bool: 存在返回True，不存在返回False。
        """
        return self._query(path, **attrs).exists()

    @deco.keyword("元素不存在")
    def not_exist(self, path=None, **attrs) -> bool:
        """元素如果不存在返回False，不会抛出异常。

        Args:
            path (Query, optional): 路径或元素对象. Defaults to None.

        Returns:
            bool: 存在返回True，不存在返回False。
        """
        return not self._query(path, **attrs).exists()

    @deco.keyword("元素必须存在")
    def should_exist(self, path=None, **attrs):
        """元素存在断言，如果不存在会抛出异常，并导致测试失败。

        Args:
            path (Query, optional): 路径或元素对象. Defaults to None.
        """
        # BuiltIn里的Run Keyword 系列方法都不支持传递kwargs，
        # 所以kwattr用来接收等待元素出现、等待元素消失传递过来的字典参数
        self.snap("元素必须存在")
        if self.exists(path, **attrs) is False:
            BuiltIn().fail(msg="<{}:{}>元素必须存在".format(str(path), attrs))

    @deco.keyword("元素必须不存在")
    def should_not_exist(self, path=None, **attrs):
        """元素不存在断言，如果存在会抛出异常，并导致测试失败。

        Args:
            path (Query, optional): . Defaults to None.
        """
        self.snap("元素必须不存在")
        if self.exists(path, **attrs) is True:
            BuiltIn().fail(msg="<{}:{}>元素必须不存在".format(str(path), attrs))

    @deco.keyword("等待元素出现")
    def wait_for_appearance(self, path=None, time_out: str = "5 sec", **attrs):
        """等待元素出现

        Args:
            path (str|UIObjectProxy, optional): 路径或元素对象. Defaults to None.
            time_out (str, optional): 超时时间, e.g. 2 min 5 sec
            Defaults to "5 sec".
        """
        start = time.time()
        time_out = timestr_to_secs(time_out)
        while time.time() - start < time_out:
            if self.exists(path, **attrs):
                return True
            else:
                time.sleep(1)
                # 强行调用一次 _start_keyword 用来触发 UIWatcher的检查
                self._start_keyword("等待元素出现Loop", {})

        BuiltIn().fail("<{}:{}> 没有出现".format(path, attrs))

    @deco.keyword("等待元素消失")
    def wait_for_disappearance(self, path=None, time_out: str = "5 sec", **attrs):
        """等待元素消失

        Args:
            path (str|UIObjectProxy, optional): 路径或元素对象. Defaults to None.
            time_out (str, optional): 超时时间, e.g. 2 min 5 sec.
            Defaults to "5 sec".
        """
        start = time.time()
        time_out = timestr_to_secs(time_out)
        while time.time() - start < time_out:
            if not self.exists(path, **attrs):
                return True
            else:
                time.sleep(1)
                self._start_keyword("等待元素消失Loop", {})

    @deco.keyword("滑动屏幕")
    def swipe_screen(
        self,
        p1: Point,
        p2: Point,
        direction: Optional[Point] = None,
        duration: float = 0.5,
    ):
        """整个屏幕上做滑动, 以duration时间长度从p1滑动到p2. e.g. 用5s的时间从p1滑动到p2.

        Args:
            p1 (Point): 起始点
            p2 (Point): 结束点
            direction (Point, optional): 滑动方向. Defaults to None.
            duration (float, optional): 间隔时长. Defaults to 0.5.
        """
        self._robot_snap()
        self.poco.swipe(p1, p2, direction, duration)

    @deco.keyword("滑动元素")
    def swipe_element(
        self,
        path=None,
        direction: Point = POS_ZERO,
        focus: Point = POS_CENTER,
        duration: float = 0.5,
        **attrs,
    ):
        """在元素内滑动

        Args:
            path (str|UIObjectProxy, optional): 路径或元素对象. Defaults to None.
            direction (Point, optional): 方向, 可以是'horizontal'或'vertical'
            Defaults to [0, 0].
            focus (Point, optional): 焦点. Defaults to [0.5, 0.5].
            duration (float, optional): 间隔时长. Defaults to 0.5.
        """
        self._robot_snap()
        self._query(path, **attrs).swipe(direction, focus, duration)

    @deco.keyword("滑动列表")
    def scroll_list(
        self,
        path=None,
        direction: str = "vertical",
        percent: float = 0.6,
        duration: float = 2,
        **attrs,
    ):
        """与滑动元素相似，但是提供更加直观的百分比来控制滑动的幅度。

        Args:
            path (str|UIObjectProxy, optional): 路径或元素对象. Defaults to None
            direction (str, optional):方向, 可以是'horizontal'或'vertical'
            Defaults to "vertical".
            percent (float, optional): 滑动幅度. Defaults to 0.6.
            duration (float, optional): 间隔时长. Defaults to 2.
        """
        self._robot_snap()
        self._query(path, **attrs).scroll(direction, percent, duration)

    @deco.keyword("循环 ${kw1} 直到 ${kw2}")
    def run_keyword_until(self, kw1, kw2):
        """为了可读性，传入关键字不支持参数。要求自己去创建自定义关键字kw1和kw2，然后再用这个关键字。
        这个关键字跟Run Keyword Until Successed作用一样，只不过更加符合中文语法。
        """
        while BuiltIn().run_keyword(kw2) is False:
            time.sleep(1)
            BuiltIn().run_keyword(kw1)

    @deco.keyword("截图日志")
    def snap(self, msg=""):
        """
        此截图会在rb和airtest的日志里都写入记录
        """
        try:
            filename, _ = self._log_snap()
            if filename and self._poco:
                snapshot(filename, msg=msg)
        except Exception as e:
            logger.warn(e)

    @deco.keyword("生成随机角色名")
    def create_usename(self) -> str:
        """通过时间戳生成随机名字，取的是时间戳16进制的1~8位。

        Returns:
            str: 名字
        """
        timestamp = int(time.time())
        return hex(timestamp).replace("0x", "")[1:8]

    @deco.keyword("键盘输入")
    def input(self, key_seg: str):
        """
        用按键事件输入，支持英文数字和标点，有些控件要键盘事件才能够触发一些行为的时候用这个输入内容
        """
        for char in key_seg:
            keyevent(char)

    @deco.keyword("PocoRPC调用")
    def poco_rpc_call(self, method: str, *args):
        client: RpcClient = self.poco.agent.rpc
        cb = client.call(method, *args)
        ret, err = cb.wait(timeout=20)
        if err:
            logger.error("{}，检查是不是游戏客户端的PocoManaager没有接入{}".format(err, method))
        else:
            return ret

    def _scroll_to(
        self, scroll_view: UIObjectProxy, item: UIObjectProxy, duration: float = 1
    ):
        list_pos = scroll_view.get_position()
        list_size = scroll_view.get_size()
        item_pos = item.get_position()

        def item_move2screen(item_pos):
            # 判断是否在屏幕内，因为有可能预制体大于屏幕，将需要点击的item从屏幕外拖动回屏幕中间再操作
            direction = []
            if item_pos[0] > 1:
                direction.append(0.9)
            elif item_pos[0] < 0:
                direction.append(0.1)
            else:
                direction.append(0.5)

            if item_pos[1] > 1:
                direction.append(0.9)
            elif item_pos[1] < 0:
                direction.append(0.1)
            else:
                direction.append(0.5)

            times1 = math.ceil(abs(item_pos[0] - 0.5) / 0.4)
            times2 = math.ceil(abs(item_pos[1] - 0.5) / 0.4)
            times = max(times1, times2)
            for i in range(times):
                self.swipe_screen(direction, [0.5, 0.5])

        if 0 > item_pos[0] or item_pos[0] > 1 or 0 > item_pos[1] or item_pos[1] > 1:
            item_move2screen(item_pos)
            item_pos = item.get_position()

        def item_visible(list_pos, list_size, item_pos):
            # 判断item是不是已经在列表可视范围内

            # 修改为将要点击的元素的中心位置和列表的四个角比较是否在列表内
            return (
                list_pos[0] - list_size[0] / 2
                <= item_pos[0]
                <= list_pos[0] + list_size[0] / 2
                and list_pos[1] - list_size[1] / 2
                <= item_pos[1]
                <= list_pos[1] + list_size[1] / 2
            )

        if not item_visible(list_pos, list_size, item_pos):
            # 如果item不在list范围内，就滑动
            direction = [list_pos[0] - item_pos[0], list_pos[1] - item_pos[1]]

            # 求出(list_size[0], list_size[1]) 向量长度
            list_area = list_size[0] ** 2 + list_size[1] ** 2
            # 求出方向向量长度
            direction_area = direction[0] ** 2 + direction[1] ** 2
            # 滑动次数 = 方向向量长度/ size向量长度，因为我没有开方所以要*2
            times = direction_area / list_area

            times = math.ceil(times)
            direction = [direction[0] / times, direction[1] / times]

            for i in range(times):
                scroll_view.swipe(direction, focus=(0.5, 0.5), duration=duration)

        time.sleep(2)  # 大部分滚动都有个回弹，预留点时间

    @deco.keyword("获取列表项数量")
    def get_list_item_count(self, scroll_view_path, item_path=None, **attrs) -> int:
        """参数与获取所有列表项相同，先获取所有列表项再 返回len(items)，仅此而已。

        Args:
            scroll_view_path (Query): 滑动界面、列表界面查询路径
            item_path (Query, optional): 列表项查询路径. Defaults to None.
        Returns:
            int: 列表项数量
        """

        # 先找到列表元素
        return len(self.get_list_items(scroll_view_path, item_path, **attrs))

    @deco.keyword("获取所有列表项")
    def get_list_items(
        self, scroll_view_path, item_path=None, **attrs
    ) -> "list[UIObjectProxy]":
        """
        如果item_path没有传入，则默认认为scroll_view_path下所有孩子是列表项。
        然而实际上列表项不一定能够都是scroll_view_path直接孩子，比如Unity
        里ScrollView下面还会套好几层，Content才是真正装载列表项的容器元素，因此
        提供的item_path就是用来指定ScrollView下面什么元素才是真正的列表项。

        例子：
            ${所有项}    获取所有列表项    Scroll View    item_path=?nameMatches=Text.*

        上面例子中会找到Scroll Views下面所有匹配item_path的元素。item_path也可以用界面模型
        的元素变量传入。

        例子：
            ${所有项}    获取所有列表项    Scroll View    item_path=${Scroll_View.Item}

        Args:
            scroll_view_path (Query): 滑动界面、列表界面查询路径
            item_path (Query, optional): 列表项查询路径. Defaults to None.

        Returns:
            List[UIObjectProxy]: 所有项列表
        """
        # 先找到列表元素
        scroll_view = self._query(scroll_view_path)
        if item_path:
            item_queryinfo = parse_path_to_queryinfos(item_path, **attrs)[-1]
            item_queryinfo["attrs"].update(attrs)
            items = scroll_view.offspring(
                item_queryinfo["name"], **item_queryinfo["attrs"]
            )
            return items
        else:
            logger.console("2")
            return scroll_view.children()

    @deco.keyword("通过索引获取列表项")
    def get_list_item_by_index(
        self, scroll_view_path, index: int, item_path: str = None, **attrs
    ) -> UIObjectProxy:
        """
        列表下有10个项目，你想直接获取第3个项元素，可以用这个关键字。

        例子：
            ${项}    通过索引获取列表项    Scroll View    12
            item_path=?nameMatches=Text.*


        Args:
            scroll_view_path (Query): 滑动界面、列表界面查询路径
            index (int): 索引
            item_path (str, optional): 列表项查询路径. Defaults to None

        Returns:
            UIObjectProxy: 获取到的项元素
        """
        return self.get_list_items(scroll_view_path, item_path, **attrs)[index]

    @deco.keyword("通过文本获取列表项")
    def get_list_item_by_text(
        self, scroll_view_path, item_text: str, item_path=None, **attrs
    ) -> UIObjectProxy:
        """
        通过列表项包含的文字来获取列表项。比如我们列表项里带有文字，我们可以通过这些文字
        来找到这个列表项。这个关键字默认会找列表下面所有的孩子，找到带有item_text文本的元素，
        但是这样子返回的就不是列表项元素本身，而是列表项元素下面的某个子孙。如果要返回列表项
        本身需要传入item_path告诉关键字什么样的元素是列表项。

        注意：这个关键字目前性能很差，列表很大的话会因为查询而导致耗时很高。

        例子：
            ${项}    通过文本获取列表项    Scroll View    Item 12

        上面的例子就会获得text属性是Item 12的元素，但是这个元素并不是列表项，而是列表项的子孙之一，
        一般会是个Label。

        例子:
            ${项}    通过文本获取列表项    Scroll View    Item 12
            item_path=?nameMatches=Text.*

        上面的例子意思是 列表项是item_path， 我要找item_path和其子孙中text属性是Item 12的那个item_path。
        那么最终返回的元素就是item_path匹配的元素，而不是一个Label了。

        Args:
            scroll_view_path (Query): 滑动界面、列表界面查询路径
            item_text (str): 项包含的文本
            item_path (Query, optional): 列表项查询路径. Defaults to None.

        Returns:
            UIObjectProxy: 获取到的项元素
        """
        scroll_view = self._query(scroll_view_path)

        if item_path:
            # 指定了item_path，那么就取item_path最后一段查询在scroll_view元素下查找
            item_queryinfo = parse_path_to_queryinfos(item_path, **attrs)[-1]
            item_queryinfo["attrs"].update(attrs)

            items = scroll_view.offspring(
                item_queryinfo["name"], **item_queryinfo["attrs"]
            )

            for item in items:
                if item.get_text() and re.match(item_text, item.get_text()):
                    return item
                else:
                    found = item.offspring(textMatches=item_text)
                    if found.exists():
                        return item
            BuiltIn().fail("没有找到元素")
        else:
            # 如果没有指定item_path，那么就直接查找文本
            item_label = scroll_view.offspring(textMatches=item_text)
            return item_label

    @deco.keyword("通过文本点击列表项")
    def click_list_item_by_text(
        self,
        scroll_view_path,
        item_text: str,
        item_path=None,
        click_path=None,
        focus=(0.5, 0.5),
        duration: float = 2,
        **attrs,
    ):
        """参数跟通过文本获取列表项大致相同，但是多了click_path这个参数。
           有的列表项并不是整个都可以点击，而是列表项内嵌了一些按钮，那些按钮可以点击。
           我们找到列表项后希望去点击列表项里的那些按钮，那么就需要传入click_path。

           例子：
                通过文本点击列表项    Scroll View    Item 12
                click_path=?textMatches=领取

            比如我们的列表项里面有一个领取按钮，这个按钮才是我们想要点的，而列表项内有文本Item 12，
            那么我们就传入 click_path=?textMatches=领取，这样找到列表项后会再次找其孩子里文本
            属性是‘领取’的元素去点击。
        Args:

            scroll_view_path (Query): 滑动界面、列表界面查询路径
            item_text (str): 项包含的文本
            item_path (Query, optional): 列表项查询路径. Defaults to None.
            click_path (Query, optional): 点击的元素路径. Defaults to None.
            focus (tuple, optional): 点击焦点. Defaults to (0.5, 0.5).
            duration (float, optional): 滑动时间，越小越快. Defaults to 1
        """
        scroll_view = self._query(scroll_view_path)
        item = self.get_list_item_by_text(scroll_view_path, item_text, item_path)
        logger.console("正在计算滑动距离...")
        self._scroll_to(scroll_view, item, duration)

        if click_path:
            raw_path = parse_path_to_queryinfos(click_path, **attrs)[-1]
            item = item.offspring(raw_path["name"], **raw_path["attrs"])
        item.click(focus)

    @deco.keyword("通过索引点击列表项")
    def click_list_item_by_index(
        self,
        scroll_view_path,
        index: int,
        item_path=None,
        click_path=None,
        focus=(0.5, 0.5),
        duration: float = 1,
        **attrs,
    ):
        """参数跟通过索引获取列表项大致相同，但是多了click_path这个参数。
           有的列表项并不是整个都可以点击，而是列表项内嵌了一些按钮，那些按钮可以点击。
           我们找到列表项后希望去点击列表项里的那些按钮，那么就需要传入click_path。

           例子：
                通过索引点击列表项    Scroll View    12    item_path=?textMatches=领取

            比如我们的列表项里面有一个领取按钮，这个按钮才是我们想要点的，而列表项内有文本Item 12，
            那么我们就传入 click_path=?textMatches=领取，这样找到列表项后会再次找其孩子里文本
            属性是‘领取’的元素去点击。

        Args:
            scroll_view_path (Query): 滑动界面、列表界面查询路径

            index (int): 索引

            item_path (str, optional): 列表项查询路径. Defaults to None

            click_path (Query, optional): 点击的元素路径. Defaults to None.

            focus (tuple, optional): 点击焦点. Defaults to (0.5, 0.5).

            duration (float, optional): 滑动时间，越小越快. Defaults to 1
        """
        scroll_view = self._query(scroll_view_path)
        item = self.get_list_item_by_index(scroll_view_path, index, item_path)
        self._scroll_to(scroll_view, item, duration)

        if click_path:
            raw_path = parse_path_to_queryinfos(click_path, **attrs)[-1]
            item = item.offspring(raw_path["name"], **raw_path["attrs"])

        item.click(focus)

    @deco.keyword("按住")
    def gesture_start(self, path=None, focus: Point = POS_CENTER, **attrs):
        """模拟连续的手势操作，这个关键字专门用来解决 “按住1s然后拖动到目标位置放开”
        “在画板上画图签名”这种复杂的组合操作。

        这个关键字是一组关键字，相关关键字是：按住、保持、到、放开。

        例子：

            按住    ${btn_star}\n
            保持    1 secs\n
            到    ${shell}\n
            放开\n

        Args:
            path (Query, optional): 查询路径. Defaults to None.
            focus (Point, optional): 点击焦点. Defaults to POS_CENTER.
        """
        platform = device_platform()
        element = path if isinstance(path, tuple) else self._query(path, **attrs)

        element._focus = focus

        if platform == "Windows":
            self._gesture = WindowsPendingGestureAction(self.poco, element)
        else:
            self._gesture = PendingGestureAction(self.poco, element)

    @deco.keyword("到")
    def gesture_to(self, path=None, focus: Point = POS_CENTER, **attrs):
        """模拟连续的手势操作，这个关键字专门用来解决 “按住1s然后拖动到目标位置放开”
        “在画板上画图签名”这种复杂的组合操作。

        这个关键字是一组关键字，相关关键字是：按住、保持、到、放开。

        `按住`和`放开`一定要成对，不然就会一直按住了。

        例子：

            按住    ${btn_star}\n
            保持    1 secs\n
            到    ${shell}\n
            放开\n

        Args:
            path (Query, optional): 查询路径. Defaults to None.

            focus (Point, optional): 点击焦点. Defaults to POS_CENTER.
        """

        if self._gesture is None:
            raise Exception("必须先调用‘按住’关键字")

        element = path if isinstance(path, tuple) else self._query(path, **attrs)

        element._focus = focus

        self._gesture.to(element)

    @deco.keyword("保持")
    def gesture_hold(self, how_long: str = "1 secs"):
        """模拟连续的手势操作，这个关键字专门用来解决 “按住1s然后拖动到目标位置放开”
        “在画板上画图签名”这种复杂的组合操作。

        这个关键字是一组关键字，相关关键字是：按住、保持、到、放开。

        例子：

            按住    ${btn_star}\n
            保持    1 secs\n
            到    ${shell}\n
            放开\n

        Args:
            how_long (str, optional): 停留时间. Defaults to None.
        """

        if self._gesture is None:
            raise Exception("必须先调用‘按住’关键字")

        secs = timestr_to_secs(how_long)
        self._gesture.hold(secs)

    @deco.keyword("放开")
    def gesture_up(self):
        """模拟连续的手势操作，这个关键字专门用来解决 “按住1s然后拖动到目标位置放开”
        “在画板上画图签名”这种复杂的组合操作。

        这个关键字是一组关键字，相关关键字是：按住、保持、到、放开。

        例子：

            按住    ${btn_star}\n
            保持    1 secs\n
            到    ${shell}\n
            放开\n
        """
        if self._gesture is None:
            raise Exception("必须先调用‘从’关键字")

        self._gesture.up()
        self._gesture = None


# endregion
