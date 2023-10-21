import click
import os
import pkg_resources
import robotframework_airtest
import webbrowser

from distutils.dir_util import copy_tree

from .util import title

from .vmg import init


@click.command()
@click.pass_context
def start(ctx: click.Context):
    """
    创建模板项目
    """
    click.echo(title("xr模板项目向导"), color="green")
    files = os.listdir(os.getcwd())
    if len(files) > 1:
        abs_path = os.path.abspath(os.path.curdir)
        answer = click.confirm(f"{abs_path}不是空目录，你是要继续在这个目录下创建吗？", default=False)

        if answer is False:
            click.echo("取消")
            return
    pkg_name = robotframework_airtest.__package__
    template_dir = pkg_resources.resource_filename(pkg_name, "template")
    copy_tree(template_dir, os.getcwd())
    click.echo(">项目文件复制完毕")

    # click要在命令里调用另一个命令得用上下文
    ctx.invoke(init)

    click.echo(">模板项目创建完毕")


@click.command()
def docs():
    """
    打开文档
    """
    webbrowser.open("https://kaluluosi.github.io/robotframework-airtest/")


def setup(group: click.Group):
    group.add_command(start)
    group.add_command(docs)
