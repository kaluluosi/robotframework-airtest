from typing import Any, Sequence, Set
from ..generatorbase import (
    ControlType,
    ElementNode,
    LoadError,
    ViewModel,
)
from unityparser import UnityDocument

# ui config 定义的控件类型
# DOTweenAnimation = "DOTweenAnimation"
# Image = "Image"
# Text = "Text"
# InputField = "InputField"
# RectTransform = "RectTransform"
# Slider = "Slider"
# Canvas = "Canvas"
# ToggleGroup = "ToggleGroup"
# ContentSizeFitter = "ContentSizeFitter"
# ExButton = "ExButton"
# LoopScrollRect = "LoopScrollRect"
# Dropdown = "Dropdown"
# CanvasGroup = "CanvasGroup"
# RawImage = "RawImage"
# ExImage = "ExImage"
# ExDropdown = "ExDropdown"
# TextMeshProUGUI = "TextMeshProUGUI"
# ExToggle = "ExToggle"
# PageScroller = "PageScroller"
# ExText = "ExText"
# ScrollRect = "ScrollRect"
# ExRichText = "ExRichText"
# EnhancedScrollerContro = "EnhancedScrollerController"
# ExSkeletonGraphic = "ExSkeletonGraphic"
# UITouchPas = "UITouchPass"


class PrefabLoadError(LoadError):
    ...


class RawData:
    def __init__(self, entry, doc: UnityDocument):
        self.entry = entry
        self.doc = doc


def find_go_by_name(doc: UnityDocument, name: str) -> Any:
    gos = doc.filter(class_names=("GameObject",), attributes=("m_Name", "m_Component"))

    for go in gos:
        if go.m_Name == name:
            return go


def find_entry_by_id(doc: UnityDocument, id: str) -> Any:
    for entry in doc.entries:
        if entry.anchor == str(id):
            return entry

    return None


def find_root_entry(doc: UnityDocument):
    rect_transforms = doc.filter(
        class_names=("RectTransform",), attributes=("m_Father",)
    )

    for rect_transform in rect_transforms:
        # RectTransform 的 m_Father: {fileID: 0} 就是根节点
        if rect_transform.m_Father["fileID"] == 0:
            go_id = rect_transform.m_GameObject["fileID"]
            return find_entry_by_id(doc, go_id)


class UnityElementNode(ElementNode):
    def __init__(self, raw_data: RawData, parent: ElementNode = None):
        self._raw_data = raw_data
        self._parent = parent
        self._name = self.path = str(self._raw_data.entry.m_Name)

    @property
    def components(self) -> Sequence:
        components = []
        components_refs = self._raw_data.entry.m_Component
        for comp_ref in components_refs:
            _id = comp_ref["component"]["fileID"]
            comp_entry = find_entry_by_id(self._raw_data.doc, _id)
            components.append(comp_entry)

        return components

    @property
    def name(self) -> str:
        if self.parent:
            return "_".join([self.parent.name, self._name])

        return self._name

    @name.setter
    def name(self, value: str) -> str:
        self._name = value

    @property
    def type(self) -> Set[ControlType]:
        types = set([ControlType.Default])
        for comp in self.components:
            if hasattr(comp, "m_Text"):
                types.add(ControlType.Text)

            if hasattr(comp, "m_ScrollSensitivity"):
                types.add(ControlType.List)

            if hasattr(comp, "m_CharacterLimit"):
                types.add(ControlType.Input)

            types.add(ControlType.Default)

        if self.is_root_node:
            types.add(ControlType.Root)

        return types

    @property
    def children(self) -> Sequence["UnityElementNode"]:
        if self.rect_transform is None:
            return []

        doc = self._raw_data.doc

        children_nodes = []

        for child_refs in self.rect_transform.m_Children:
            _id = child_refs["fileID"]
            rect_transform_entry = find_entry_by_id(doc, _id)
            if hasattr(rect_transform_entry, "m_GameObject"):
                _go_id = rect_transform_entry.m_GameObject["fileID"]
                go = find_entry_by_id(doc, _go_id)
                unity_node = UnityElementNode(RawData(go, doc), parent=self)
                children_nodes.append(unity_node)

        return children_nodes

    @property
    def rect_transform(self) -> Any:
        for comp in self.components:
            if hasattr(comp, "m_Children") and hasattr(comp, "m_GameObject"):
                return comp

        return None


class UnityViewModel(ViewModel):
    def __init__(self, ui_file: str, extra_info: dict = None) -> None:
        super().__init__(ui_file, extra_info)
        self._libraries = ["robotframework_airtest.poco.UnityPocoLibrary"]

    def load(self, ui_file: str) -> ElementNode:
        doc = UnityDocument.load_yaml(ui_file)
        entry = find_root_entry(doc)
        if entry is None:
            # 如果一个prefab下面全是引用其他子prefab，那么prefab文件里就不存在m_Fathor: {fileID: 0}的RectTransform，会导致根元素查找失败
            # 目前没有很好的办法去确定这种prefab下到底哪个是根节点，只好跳过不解析
            raise PrefabLoadError(f"{ui_file}这个界面不适合生成，可能是引用组合prefab")
        raw_data = RawData(entry, doc)
        root = UnityElementNode(raw_data, None)
        return root


def generate(input: str, output: str, extra_info: dict = None):
    UnityViewModel(input, extra_info).gen(output)
