import toml

from pydantic import BaseModel, RootModel, Field
from typing import Dict, List


class Setting(BaseModel):
    source: str = Field(default="views", description="你的前端界面资源文件存放目录")
    dist: str = Field(default="view_models", description="你的界面模型资源输出目录")
    exts: List[str] = Field(default=[".prefab"], description="界面资源文件格式")
    generator: str = Field(default="unity", description="界面模型导出器")


class Settings(RootModel[Dict[str, Setting]]):
    root: Dict[str, Setting] = {}

    @classmethod
    def load(cls, file: str = "vmg.toml"):
        data = toml.load(file)
        return cls.model_validate(data)

    def save(self, file: str = "vmg.toml"):
        with open(file, "w", encoding="utf-8") as f:
            toml.dump(self.model_dump(), f)
