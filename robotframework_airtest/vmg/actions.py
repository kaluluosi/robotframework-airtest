import textwrap
from abc import ABC, abstractmethod
from typing import Callable, TYPE_CHECKING
from robotframework_airtest.poco.std import StdPocoLibrary

if TYPE_CHECKING:
    from .generatorbase import ElementNode


class Action(ABC):
    def __init__(self, node: "ElementNode"):
        self._node = node

    @property
    @abstractmethod
    def template(self) -> str:
        ...

    def __str__(self):
        return textwrap.dedent(self.template)

    def _get_kwname(self, method: Callable):
        return getattr(method, "robot_name")


class FindAction(Action):
    """
    获取元素
    """

    @property
    def template(self) -> str:
        find_element = self._get_kwname(StdPocoLibrary.find_element)
        return f"""
        {self._node.name}
            [Return]    ${{元素对象}}
            ${{元素对象}}    {find_element}    {self._node.path}
        """


class ClickAction(Action):
    """
    点击
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.click_element)
        return f"""
        点击{self._node.name}
            [Arguments]     ${{focus}}=(0.5,0.5)
            {kwname}    {self._node.path}    ${{focus}}
        """


class LongClickAction(Action):
    """
    点击
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.long_click_element)
        return f"""
        长按{self._node.name}
            [Arguments]     ${{focus}}=(0.5,0.5)    ${{duration}}=${{Empty}}
            {kwname}    {self._node.path}    ${{focus}}
        """


class InputAction(Action):
    """
    输入文字
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.input_text)
        return f"""
        输入文字{self._node.name}
            [Arguments]     ${{文本}}     ${{键盘输入}}=${{False}}
            {kwname}    {self._node.path}   ${{文本}}    ${{键盘输入}}
        """


class TextAction(Action):
    """
    获取文字
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.get_text)
        return f"""
        获取文字{self._node.name}
            [Return]    ${{文本}}
            ${{文本}}    {kwname}    {self._node.path}
        """


class ListLengthAction(Action):
    """
    获取列表项数量
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.get_list_item_count)
        return f"""
        获取{self._node.name}列表项数量
            [Arguments]     ${{item_path}}=${{None}}
            [Return]    ${{数量}}
            ${{数量}}     {kwname}    {self._node.path}     item_path=${{item_path}}
        """


class ListItemsAction(Action):
    """
    获取所有列表项
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.get_list_items)
        return f"""
        获取{self._node.name}所有列表项
            [Arguments]     ${{item_path}}=${{None}}
            [Return]   ${{列表项数组}}    
            ${{列表项数组}}     {kwname}    {self._node.path}    item_path=${{item_path}}
        """


class ListItemByIndexAction(Action):
    """
    根据索引获取列表项
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.get_list_item_by_index)
        return f"""
        获取{self._node.name}列表项_索引
            [Arguments]     ${{索引}}    ${{item_path}}=${{None}}
            [Return]    ${{项}}
            ${{项}}     {kwname}    {self._node.path}    ${{索引}}    item_path=${{item_path}}
        """


class ListItemByTextAction(Action):
    """
    根据文本获取列表项
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.get_list_item_by_text)
        return f"""
        获取{self._node.name}列表项_文本
            [Arguments]    ${{文本}}    ${{item_path}}=${{None}}
            [Return]    ${{项}}
            ${{项}}    {kwname}     {self._node.path}    ${{文本}}    item_path=${{item_path}}
        """


class ClickItemByIndexAction(Action):
    """
    点击指定下标的列表项
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.click_list_item_by_index)
        return f"""
        点击{self._node.name}列表项_索引
            [Arguments]    ${{索引}}    ${{item_path}}=${{None}}    ${{click_path}}=${{None}}    ${{focus}}=(0.5,0.5)
            {kwname}    {self._node.path}    ${{索引}}    item_path=${{item_path}}    click_path=${{click_path}}    focus=${{focus}}
        """


class ClickItemByTextAction(Action):
    """
    点击带有文本的列表项
    """

    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.click_list_item_by_text)
        return f"""
        点击{self._node.name}列表项_文本
            [Arguments]    ${{文本}}    ${{item_path}}=${{None}}    ${{click_path}}=${{None}}    ${{focus}}=(0.5,0.5)
            {kwname}    {self._node.path}     ${{文本}}    item_path=${{item_path}}    click_path=${{click_path}}    focus=${{focus}}

        """


class ViewExistAction(Action):
    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.exists)
        return f"""
        界面存在
            [Return]    ${{结果}}
            ${{结果}}    {kwname}    ${{{self._node.name}}}
        """


class ViewShouldExistAction(Action):
    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.should_exist)
        return f"""
        界面必须存在
            [Return]    ${{结果}}
            ${{结果}}    {kwname}    ${{{self._node.name}}}
        """


class ViewNotExistAction(Action):
    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.exists)
        return f"""
        界面不存在
            [Return]    ${{结果}}
            ${{结果}}     {kwname}    ${{{self._node.name}}}
            ${{结果}}    Evaluate    not ${{结果}}
        """


class ViewShouldNotExistAction(Action):
    @property
    def template(self) -> str:
        kwname = self._get_kwname(StdPocoLibrary.should_not_exist)
        return f"""
        界面必须不存在
            {kwname}    ${{{self._node.name}}}
        """
