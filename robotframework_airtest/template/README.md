# 说明


## 开发环境设置

1. Python版本：由于`Airtest/pocoui`只支持 `Python 3.6 ~ Python 3.8` ，所以我们的`Python`版本建议使用`3.8`。
2. 用`pip`安装 `robotframework-airtest`（你能创建这个项目，说明你已经安装了）
3. vscode插件安装 `robotframework-lsp`

## 快速开始

将 [com.netease.poco.u3d.tutorial.apk](https://github.com/kaluluosi/robotframework-airtest/blob/main/tests/demo/com.netease.poco.u3d.tutorial.apk) 示例应用安装到手机上
`vscode`打开 `Tests\示例测试.robot`
![](asset/2023-10-21-05-06-28.png)
如果 `robotframework-lsp` 安装正确，那么你会在用例左边看到播放按钮，用例上面也会看到调试按钮。如果你在`vscode`用过 `unittest` `pytest` 那么怎么用`vscode`调试测试用例应该不需要我多说了。点击播放按钮就可以单独执行这个用例。

![](asset/2023-10-21-05-09-16.png)
![](asset/2023-10-21-05-09-30.png)

看到 `Hello World` 说明测试用例执行成功。


## VSCODE开发调试

在编写调试用例的阶段，我们使用`vscode`自己的测试调试功能。
![](asset/2023-10-21-05-09-16.png)

你可以执行单个测试用例，断点调试。这样就不用另外编写命令行指定单个用例，而且有断点调试更方便测试。

## 命令行运行

当我们需要完整执行某一批用例时，我们使用命令行来执行。命令行执行分两种。

### `vscode` 任务

我在`vscode`的`tasks.json`中配置了命令行执行的命令。你可以通过 `ctrl+p`+`>任务：运行任务`，执行这些任务。

![](asset/2023-10-21-05-20-24.png)

- 运行所有测试 —— 执行 Tests目录下所有测试，并生成测试报告到`Logs`目录
- 打开调试报告 —— 打开根目录下的调试产生的report.html
- 打开报告 —— 打开 Logs目录下的report.html
- 更新界面模型 —— 执行 `ra vmg` 命令
- 干跑测试 —— 干跑检查所有用例是否正确编写，用于检查语法或者界面模型更改

这些任务是用作 `vscode` 本地运行用。

![](asset/2023-10-21-05-30-41.png)

执行完可以在最后三行看到输出的报告链接，点击即可在浏览器中查看。

### 命令行执行

自动化测试最终还是要面向CI\CD自动集成，在CI\CD环境下就需要使用命令行来执行所有用例并输出报告。

在项目根目录下，执行 `robot -A Args/run.args Tests` 命令，执行所有测试用例。

`Args` 目录下预置了很多配置文件，你可以根据需要修改这些配置文件，或直接通过 `-A` 参数传递给
`robot` 命令。

本项目最为核心的部分是环境变量：

- pkg_name —— pc客户端启动程序
- device_uri —— 设备连接字符串
- auto_start_app —— 自动开启app
- serverid —— 登录的服务器id
- language —— 语言

默认情况下 `.args` 文件都通过 `config.py` 这个文件获取跟`vscode setting.json` 一致的环境变量。你也可以自行通过 `robot` 的 `--variable` 参数传递，去覆盖`.args`的配置。

```shell
robot --variable "pkg_name:xxx" --variable "device_uri:xxx" --variable "auto_start_app:xxx" --variable "serverid:xxx" --variable "language:xxx" -A Args/run.args Tests
```