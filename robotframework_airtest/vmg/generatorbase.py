import os
from abc import ABC, abstractmethod
from enum import Enum
from typing import Callable, Dict, Sequence, Set

from jinja2 import Template
import pkg_resources

from .logger import logger
from .actions import (
    FindAction,
    ClickAction,
    LongClickAction,
    InputAction,
    TextAction,
    ListLengthAction,
    ListItemsAction,
    ListItemByIndexAction,
    ListItemByTextAction,
    ClickItemByIndexAction,
    ClickItemByTextAction,
    ViewExistAction,
    ViewShouldExistAction,
    ViewNotExistAction,
    ViewShouldNotExistAction,
    Action,
)

ActionMap = Dict
GeneratorFunc = Callable[[str, str, dict], None]


class ControlType(Enum):
    """控件类型，导出工具根据空间类型决定要生成哪些关键字

    Args:
        Enum ([type]): [description]
    """

    Default = 0  # 默认控件
    Text = 1
    Input = 2
    List = 3
    Root = 4


class ElementNode(ABC):

    """从界面文件中解析出来的树状界面模型"""

    ACTION_MAP: ActionMap = {
        ControlType.Default: [FindAction, ClickAction, LongClickAction],
        ControlType.Text: [InputAction, TextAction],
        ControlType.Input: [InputAction, TextAction],
        ControlType.List: [
            ListLengthAction,
            ListItemsAction,
            ListItemByIndexAction,
            ListItemByTextAction,
            ClickItemByIndexAction,
            ClickItemByTextAction,
        ],
        ControlType.Root: [
            ViewExistAction,
            ViewShouldExistAction,
            ViewNotExistAction,
            ViewShouldNotExistAction,
        ],
    }

    QUERY = "?nameMatches\={}.*"

    def __init__(self):
        """节点抽象基类，要怎么实现这个基类的所有虚方法看具体情况。"""
        self._path = ""
        self._name = ""
        self._type = []

    @property
    @abstractmethod
    def children(self) -> Sequence["ElementNode"]:
        """返回所有孩子节点"""
        ...

    @property
    def path(self) -> str:
        if self.parent and not self.parent.is_root_node:
            return "\\\\".join([self.parent.path, self._path])
        return self._path

    @path.setter
    def path(self, value: str):
        self._path = self.QUERY.format(value)

    @property
    @abstractmethod
    def name(self, value) -> str:
        self._name = value

    @name.setter
    @abstractmethod
    def name(self) -> str:
        """返回元素名

        Returns:
            str: 元素名
        """
        return self._name

    @property
    @abstractmethod
    def type(self) -> Set[ControlType]:
        """返回元素的控件类型

        Returns:
            str: [description]
        """
        return self.type

    @property
    def parent(self) -> "ElementNode":
        return self._parent

    @property
    def is_root_node(self) -> bool:
        return self.parent is None

    @property
    def actions(self) -> Sequence[Action]:
        actions = []
        action_clses = []
        for type in self.type:
            action_clses += self.ACTION_MAP[type]

        action_clses = set(action_clses)

        for action_cls in action_clses:
            actions.append(action_cls(self))

        return actions


class ViewModel(ABC):
    def __init__(self, ui_file: str, extra_info: dict = None) -> None:
        """[summary]

        Args:
            ui_file (str): [description]
            root_node_path (str, optional): 界面根节点查询路径. Defaults to None.
        """
        self._ui_file = ui_file
        self._libraries = []
        self._resources = []
        self.extra_info = extra_info
        logger.info(f"解析 {ui_file}")
        self.root_node = self.load(ui_file)

    @abstractmethod
    def load(self, ui_file: str) -> ElementNode:
        ...

    @property
    def name(self) -> str:
        return self.root_node.name

    @property
    def path(self) -> str:
        return self.root_node.path

    @property
    def libraries(self) -> Sequence[str]:
        return self._libraries

    @property
    def resources(self) -> Sequence[str]:
        return self._resources

    @property
    def variables(self) -> Sequence[str]:
        variables = []
        name_counter = {}

        def DFS(node: ElementNode):
            name = node.name.lower()
            if name not in name_counter:
                name_counter[name] = 1
            else:
                name_counter[name] += 1

            count = name_counter[name]
            if count > 1:
                node.name = "_".join([node.name, str(count)])

            variables.append(node)
            for c in node.children:
                DFS(c)

        DFS(self.root_node)
        return variables

    def gen(self, output: str):
        vm = self

        try:
            # package data 文件需要用 pkg_resources来定位访问，不要自行拼接相对路径
            temp_txt = pkg_resources.resource_string(__name__, "template.robot").decode(
                "utf-8"
            )
            template = Template(temp_txt)
            txt = template.render(ui=vm, type=ControlType)

            outdir = os.path.dirname(output)

            if not os.path.exists(outdir):
                os.makedirs(outdir)

            with open(output, "w", encoding="utf-8") as f:
                f.write(txt)
                logger.info("导出%s-->%s", self._ui_file, output)
        except Exception as e:
            logger.error(e, exc_info=1)


class LoadError(Exception):
    ...
