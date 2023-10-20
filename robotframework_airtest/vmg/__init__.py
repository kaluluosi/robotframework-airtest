import glob
from importlib import metadata

from importlib import import_module
import os
from pkgutil import iter_modules
from typing import Optional
from .generatorbase import GeneratorFunc, LoadError
from .logger import logger  # noqa
from . import generators
from .settings import Setting


def get_valid_generators() -> dict:
    modules = filter(lambda m: m.name != "base", iter_modules(generators.__path__))
    entrypoints = metadata.entry_points().get("XR.viewmodel.generator", [])

    all_generators = {}
    for m in modules:
        module = import_module(f".{m.name}", generators.__package__)
        all_generators[m.name] = getattr(module, "generate")

    for ep in entrypoints:
        all_generators[ep.name] = ep.load()

    return all_generators


def get_valid_generator_names():
    return list(get_valid_generators().keys())


def gen_viewmodel(setting: Setting, name: Optional[str] = None):
    source = setting.source
    dist = setting.dist
    exts = setting.exts
    generator_name = setting.generator

    installed_generators = get_valid_generators()
    if generator_name not in installed_generators:
        logger.info(
            f">{generator_name} 导出器没有安装，目前安装的导出器只有{get_valid_generator_names()}",
            err=True,
        )
        logger.info(f">配置 {name} 无法处理")
    else:
        generator: GeneratorFunc = installed_generators[generator_name]
        for ext in exts:
            files = glob.glob(f"{source}/**/*{ext}", recursive=True)
            for file in files:
                outpath = file.replace(source, dist)
                # 修改扩展名
                output = os.path.splitext(outpath)[0] + ".resource"
                try:
                    generator(file, output, setting)
                except LoadError as e:
                    logger.warning(e)
