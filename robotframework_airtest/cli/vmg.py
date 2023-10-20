from typing import Callable
import click
import os

import glob
from .util import title
from robotframework_airtest.vmg import get_valid_generator_names, get_valid_generators
from robotframework_airtest.vmg.settings import Setting, Settings


@click.group()
def vmg():
    """
    界面模型导出工具
    """
    ...


@vmg.command
def gen():
    """
    根据当前目录的vmg.toml文件导出模型
    """

    click.echo(title("开始根据配置文件导出"))

    try:
        settings = Settings.load()
    except Exception as e:
        click.echo(e, err=True)
        return

    for setting_name, setting in settings.root.items():
        click.echo(f">开始处理 {setting_name}:")
        source = setting.source
        dist = setting.dist
        exts = setting.exts
        generator_name = setting.generator

        installed_generators = get_valid_generators()
        if generator_name not in installed_generators:
            click.echo(
                f">{generator_name} 导出器没有安装，目前安装的导出器只有{get_valid_generator_names()}",
                err=True,
            )
            click.echo(f">{setting_name} 无法处理")
            continue
        else:
            generator: Callable = installed_generators[generator_name]
            for ext in exts:
                files = glob.glob(f"{source}/**/*{ext}", recursive=True)
                for file in files:
                    outpath = file.replace(source, dist)
                    # 修改扩展名
                    output = os.path.splitext(outpath)[0] + ".resource"
                    generator(file, output, setting)


@vmg.command
def list():
    """
    列出所有可用的导出器
    """
    click.echo("可用的导出器：")
    for name in get_valid_generator_names():
        click.echo(f">{name}")


@vmg.command
@click.option("--default", "-d", is_flag=True, help="创建一个默认配置，然后自己去手动修改")
def init(default: bool):
    """
    创建vmg.toml配置文件
    """
    if os.path.exists("vmg.toml"):
        if not click.confirm(">当前项目目录下面已经有vmg.toml，继续创建会覆盖掉，你确定吗？", default=False):
            return

    if default:
        settings = Settings()
        settings.root["default"] = Setting()
        settings.save()
    else:
        click.echo(title("vmg.toml配置文件向导"))
        vm_source = click.prompt(
            ">前端界面资源（prefab）所在目录", default="Views", show_default=True
        )
        vm_exts: str = click.prompt(
            ">前端界面资源文件格式，空格隔开", default=".prefab", show_default=True
        )
        vm_dist: str = click.prompt(
            ">界面模型导出后保存到", default="Resources/界面模型", show_default=True
        )
        vm_generator: str = click.prompt(
            ">选择导出器",
            default="unity",
            type=click.Choice(get_valid_generators().keys()),
            show_default=True,
            show_choices=True,
        )
        settings = Settings()
        setting = Setting()
        setting.source = vm_source
        setting.dist = vm_dist
        setting.exts = vm_exts.split()
        setting.generator = vm_generator

        settings.root["default"] = setting

        settings.save()

        click.echo(">创建 vmg.toml 成功，以后要修改导出配置可以到这个文件中修改。")


def setup(group: click.Group):
    group.add_command(vmg)
